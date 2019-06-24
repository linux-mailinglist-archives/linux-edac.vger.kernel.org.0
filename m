Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7B851C42
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2019 22:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbfFXUZu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Jun 2019 16:25:50 -0400
Received: from mga04.intel.com ([192.55.52.120]:25196 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfFXUZt (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Jun 2019 16:25:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 13:25:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,413,1557212400"; 
   d="scan'208";a="336613306"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by orsmga005.jf.intel.com with ESMTP; 24 Jun 2019 13:25:48 -0700
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCH] EDAC/altera: Silence an endian warning
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>, linux-edac@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190624134717.GA1754@mwanda>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <2baa5124-f0b0-a33e-256b-6a17867862c9@linux.intel.com>
Date:   Mon, 24 Jun 2019 15:27:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190624134717.GA1754@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Dan,

On 6/24/19 8:47 AM, Dan Carpenter wrote:
> Smatch complains that we're casting a u32 pointer to unsigned long.
> 
>      drivers/edac/altera_edac.c:1878 altr_edac_a10_irq_handler()
>      warn: passing casted pointer '&irq_status' to 'find_first_bit()'
> 
> This code wouldn't work on a 64 bit big endian system because we would
> read past the end of &irq_status.
> 
> Fixes: 13ab8448d2c9 ("EDAC, altera: Add ECC Manager IRQ controller support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Static analysis obviously and I don't know this subsystem at all.
> Probably we're never going to run this on a 64 bit big endian system...
> Feel free to ignore this if you want.
> 
>   drivers/edac/altera_edac.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index c2e693e34d43..bf024ec0116c 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -1866,6 +1866,7 @@ static void altr_edac_a10_irq_handler(struct irq_desc *desc)
>   	struct altr_arria10_edac *edac = irq_desc_get_handler_data(desc);
>   	struct irq_chip *chip = irq_desc_get_chip(desc);
>   	int irq = irq_desc_get_irq(desc);
> +	unsigned long bits;
>   
>   	dberr = (irq == edac->db_irq) ? 1 : 0;
>   	sm_offset = dberr ? A10_SYSMGR_ECC_INTSTAT_DERR_OFST :
> @@ -1875,7 +1876,8 @@ static void altr_edac_a10_irq_handler(struct irq_desc *desc)
>   
>   	regmap_read(edac->ecc_mgr_map, sm_offset, &irq_status);
>   
> -	for_each_set_bit(bit, (unsigned long *)&irq_status, 32) {
> +	bits = irq_status;
> +	for_each_set_bit(bit, &bits, 32) {
>   		irq = irq_linear_revmap(edac->domain, dberr * 32 + bit);
>   		if (irq)
>   			generic_handle_irq(irq);
> 
You are correct that we shouldn't use this on a 64 bit machine but this 
is a good fix. Thank you!

Reviewed-by: Thor Thayer <thor.thayer@linux.intel.com>
