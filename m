Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C10E24FE7B
	for <lists+linux-edac@lfdr.de>; Mon, 24 Aug 2020 15:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgHXND1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Aug 2020 09:03:27 -0400
Received: from foss.arm.com ([217.140.110.172]:33588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbgHXND0 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Aug 2020 09:03:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C5921FB;
        Mon, 24 Aug 2020 06:03:20 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E98B3F66B;
        Mon, 24 Aug 2020 06:03:19 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS, edac: Calxeda Highbank, handover maintenance
 to Andre Przywara
To:     Robert Richter <rric@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200824124931.2933-1-rric@kernel.org>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <06bfa7db-5810-a184-a26c-add3fff9badf@arm.com>
Date:   Mon, 24 Aug 2020 14:02:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824124931.2933-1-rric@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 24/08/2020 13:49, Robert Richter wrote:
> I do not have hardware anymore, nor there is ongoing development. So
> handover maintenance to Andre who already maintains the last
> remainings of Calxeda.
> 
> Cc: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Robert Richter <rric@kernel.org>

Acked-by: Andre Przywara <andre.przywara@arm.com>

Thanks!
Andre

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1b7b0c1a24c8..6ed56e1a7d28 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6148,7 +6148,7 @@ S:	Supported
>  F:	drivers/edac/bluefield_edac.c
>  
>  EDAC-CALXEDA
> -M:	Robert Richter <rric@kernel.org>
> +M:	Andre Przywara <andre.przywara@arm.com>
>  L:	linux-edac@vger.kernel.org
>  S:	Maintained
>  F:	drivers/edac/highbank*
> 

