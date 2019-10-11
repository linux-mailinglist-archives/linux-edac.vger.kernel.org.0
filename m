Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E12AD3DAF
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2019 12:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfJKKtv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Oct 2019 06:49:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58004 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfJKKtv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Oct 2019 06:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+AfVulPjUsj7Th+sjwSpz+DvIhOMKWyMUlvV/+lzk58=; b=DIc5DeEWHi+eQfSKzAZ9Eu/Ct
        C4EQRo88RCKwPxoajqHuw0QCgyBGH7U6xNPbF5maqLu+gmks9isD361gwYRywGn+ZPu0pxaypH6e1
        07oolnR7/3oKT0xkkjSz7gcvmsXGWBIb2u5wvgvMqmF1iV5jRgX96VBRcJm583uine9s1tLUBj+gk
        hwyUO+4VjfSEbDeP4AP6pprcQzfr/7Cnz7spXJYasb3vEa49jQLhvltxKGQcY8SaTPcEKqCEO6y8M
        2u30/tGNM2vTh3HSlgOQXiU6apYFoADMMQAV7dSY4CdP9JbX2qqkiH60iSEP7KrYeNzbRybQ8KQG7
        kLUGA9xqw==;
Received: from 177.17.141.107.dynamic.adsl.gvt.net.br ([177.17.141.107] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIsUS-0000SJ-K3; Fri, 11 Oct 2019 10:49:45 +0000
Date:   Fri, 11 Oct 2019 07:49:40 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/19] EDAC: Remove misleading comment in struct
 edac_raw_error_desc
Message-ID: <20191011074940.30b0764b@coco.lan>
In-Reply-To: <20191010202418.25098-12-rrichter@marvell.com>
References: <20191010202418.25098-1-rrichter@marvell.com>
        <20191010202418.25098-12-rrichter@marvell.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Thu, 10 Oct 2019 20:25:26 +0000
Robert Richter <rrichter@marvell.com> escreveu:

> There never has been such function edac_raw_error_desc_clean() and in
> function ghes_edac_report_mem_error() the whole struct is zero'ed
> including the string arrays. Remove that comment.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  include/linux/edac.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/include/linux/edac.h b/include/linux/edac.h
> index 8e72222e50b0..4d9673954856 100644
> --- a/include/linux/edac.h
> +++ b/include/linux/edac.h
> @@ -458,15 +458,10 @@ struct errcount_attribute_data {
>   * @other_detail:		other driver-specific detail about the error
>   */
>  struct edac_raw_error_desc {
> -	/*
> -	 * NOTE: everything before grain won't be cleaned by
> -	 * edac_raw_error_desc_clean()
> -	 */
>  	char location[LOCATION_SIZE];
>  	char label[(EDAC_MC_LABEL_LEN + 1 + sizeof(OTHER_LABEL)) * EDAC_MAX_LABELS];
>  	long grain;
>  
> -	/* the vars below and grain will be cleaned on every new error report */
>  	u16 error_count;
>  	int top_layer;
>  	int mid_layer;



Thanks,
Mauro
