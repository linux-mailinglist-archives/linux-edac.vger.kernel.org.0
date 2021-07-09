Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720AA3C25B6
	for <lists+linux-edac@lfdr.de>; Fri,  9 Jul 2021 16:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhGIOTB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 9 Jul 2021 10:19:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231775AbhGIOTA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 9 Jul 2021 10:19:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B0C3613AF;
        Fri,  9 Jul 2021 14:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625840177;
        bh=x5CND8RsRdj7nNiTB7w585ma7e3rrEVRZa5p1+EuLHM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=htOKdpsGWv/mgxAsURjgwkEs9AEvfyh9YqU8viPhedGYX2Bd/4gSAtH9qUfgTjZRn
         VOW2Ktr9Cki/pxjw8dJglEaKMs4eMmQgAI2BQI0OIt5tWL6y95p0uPi3xLj2dCqPjq
         jpMd+LiMPkv8AzAi7PLdiWTU8O+PiUKYG8RjPKLTozsHm6J030Vw0lkOFZOEsJtMLn
         wxP4Z64Q6fWU0lJWoFCwPE2tTdEBlPYs/qGSghEARaVFevBKQ3/W/uWGx1EsnM75r2
         97t2u/nBNF0CBof4NlLJ68+Z5n+sRnhNHd0xc0Ai7SLFaScIS+i7MVzM3OegKlD8WC
         tRkwNf/4g8rhw==
Subject: Re: [PATCH] EDAC, altera: skip defining unused structures for
 specific configs
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
References: <20210601092704.203555-1-krzysztof.kozlowski@canonical.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <d08ede56-5b53-0697-de17-9eee9a8530e8@kernel.org>
Date:   Fri, 9 Jul 2021 09:16:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210601092704.203555-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 6/1/21 4:27 AM, Krzysztof Kozlowski wrote:
> The Altera EDAC driver has several features conditionally built
> depending on Kconfig options.  The edac_device_prv_data structures are
> conditionally used in of_device_id tables.  They reference other
> functions and structures which can be defined as __maybe_unused.  This
> silences build warnings like:
> 
>      drivers/edac/altera_edac.c:643:37: warning:
>          ‘altr_edac_device_inject_fops’ defined but not used [-Wunused-const-variable=]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>   drivers/edac/altera_edac.c | 44 ++++++++++++++++++++++----------------
>   1 file changed, 26 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index 61c21bd880a4..2949edb93454 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -539,10 +539,18 @@ module_platform_driver(altr_edac_driver);
>    * trigger testing are different for each memory.
>    */
>   
> +#ifdef CONFIG_EDAC_ALTERA_OCRAM
>   static const struct edac_device_prv_data ocramecc_data;
> +#endif
> +#ifdef CONFIG_EDAC_ALTERA_L2C
>   static const struct edac_device_prv_data l2ecc_data;
> +#endif
> +#ifdef CONFIG_EDAC_ALTERA_OCRAM
>   static const struct edac_device_prv_data a10_ocramecc_data;
> +#endif
> +#ifdef CONFIG_EDAC_ALTERA_L2C
>   static const struct edac_device_prv_data a10_l2ecc_data;
> +#endif
>   
>   static irqreturn_t altr_edac_device_handler(int irq, void *dev_id)
>   {
> @@ -569,9 +577,9 @@ static irqreturn_t altr_edac_device_handler(int irq, void *dev_id)
>   	return ret_value;
>   }
>   
> -static ssize_t altr_edac_device_trig(struct file *file,
> -				     const char __user *user_buf,
> -				     size_t count, loff_t *ppos)
> +static ssize_t __maybe_unused
> +altr_edac_device_trig(struct file *file, const char __user *user_buf,
> +		      size_t count, loff_t *ppos)
>   
>   {
>   	u32 *ptemp, i, error_mask;
> @@ -640,27 +648,27 @@ static ssize_t altr_edac_device_trig(struct file *file,
>   	return count;
>   }
>   
> -static const struct file_operations altr_edac_device_inject_fops = {
> +static const struct file_operations altr_edac_device_inject_fops __maybe_unused = {
>   	.open = simple_open,
>   	.write = altr_edac_device_trig,
>   	.llseek = generic_file_llseek,
>   };
>   
> -static ssize_t altr_edac_a10_device_trig(struct file *file,
> -					 const char __user *user_buf,
> -					 size_t count, loff_t *ppos);
> +static ssize_t __maybe_unused
> +altr_edac_a10_device_trig(struct file *file, const char __user *user_buf,
> +			  size_t count, loff_t *ppos);
>   
> -static const struct file_operations altr_edac_a10_device_inject_fops = {
> +static const struct file_operations altr_edac_a10_device_inject_fops __maybe_unused = {
>   	.open = simple_open,
>   	.write = altr_edac_a10_device_trig,
>   	.llseek = generic_file_llseek,
>   };
>   
> -static ssize_t altr_edac_a10_device_trig2(struct file *file,
> -					  const char __user *user_buf,
> -					  size_t count, loff_t *ppos);
> +static ssize_t __maybe_unused
> +altr_edac_a10_device_trig2(struct file *file, const char __user *user_buf,
> +			   size_t count, loff_t *ppos);
>   
> -static const struct file_operations altr_edac_a10_device_inject2_fops = {
> +static const struct file_operations altr_edac_a10_device_inject2_fops __maybe_unused = {
>   	.open = simple_open,
>   	.write = altr_edac_a10_device_trig2,
>   	.llseek = generic_file_llseek,
> @@ -1697,9 +1705,9 @@ MODULE_DEVICE_TABLE(of, altr_edac_a10_device_of_match);
>    * Based on xgene_edac.c peripheral code.
>    */
>   
> -static ssize_t altr_edac_a10_device_trig(struct file *file,
> -					 const char __user *user_buf,
> -					 size_t count, loff_t *ppos)
> +static ssize_t __maybe_unused
> +altr_edac_a10_device_trig(struct file *file, const char __user *user_buf,
> +			  size_t count, loff_t *ppos)
>   {
>   	struct edac_device_ctl_info *edac_dci = file->private_data;
>   	struct altr_edac_device_dev *drvdata = edac_dci->pvt_info;
> @@ -1729,9 +1737,9 @@ static ssize_t altr_edac_a10_device_trig(struct file *file,
>    * slightly. A few Arria10 peripherals can use this injection function.
>    * Inject the error into the memory and then readback to trigger the IRQ.
>    */
> -static ssize_t altr_edac_a10_device_trig2(struct file *file,
> -					  const char __user *user_buf,
> -					  size_t count, loff_t *ppos)
> +static ssize_t __maybe_unused
> +altr_edac_a10_device_trig2(struct file *file, const char __user *user_buf,
> +			   size_t count, loff_t *ppos)
>   {
>   	struct edac_device_ctl_info *edac_dci = file->private_data;
>   	struct altr_edac_device_dev *drvdata = edac_dci->pvt_info;
> 

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
