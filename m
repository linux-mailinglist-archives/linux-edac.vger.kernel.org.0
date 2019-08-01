Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10C027DA65
	for <lists+linux-edac@lfdr.de>; Thu,  1 Aug 2019 13:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbfHALgm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 1 Aug 2019 07:36:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39828 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729316AbfHALgm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 1 Aug 2019 07:36:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id x4so20053950wrt.6;
        Thu, 01 Aug 2019 04:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3PsNsi2Fg8DGSuD3bjQVO0TQEivknJu9Yr7/bdJYvzU=;
        b=PzoRWKjZFlYUQVRFPQQqndWwjtGZ7pWJ/SY7iVkEwJ+ACvNO6s4lbo52eQHgQuYxbq
         p5OO50Z2r8okuiaMaJZIXb5x71Lie1wQzT4UiuAxPqWtT+FirRXb9Rh1B7o0X3p/S6dL
         xtz/UkPHL0WPpbeAi0pqtF4Pxv9+lixRD82FZB+2dobhjthoV71NWf2KlhOr/0uqC4q7
         F2CNbQf+fpxP03YYC0GincfFTfJAeiGJ8jxPTFBEwtgq46VZb/S1aw/k3YmYTOlVpoGv
         C/fCXze39+uOxJjVUyU9kNKBUYtpeYvLYK2VyGj7JXL2OFCR1kXMcdRnssdIU983SgVd
         //mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3PsNsi2Fg8DGSuD3bjQVO0TQEivknJu9Yr7/bdJYvzU=;
        b=kFIXF3l7najzWRrQ1ZpVFYFIJi+qBGLiBwOKMVmiYyioPHyoakNdUomSWBfuJpLUVf
         wtKq0Cgk3nk1FKcdgAOtYHsji+b3SOEXjjm0ki7yKaWp39X3iystHGIRX0xPjv0+oNfL
         pgOi4tuaD05TPvMMjBdJlbMWiORHtmCJ5O8f9bLn88NcH7MdrZIHpvBa1D190Yz1kq1z
         yg/JHhx9nbljN4Xnufgcsb0C20XpFWOj2qZc49lCkuCfoDPsrPw7GoYelx3ycf6H3yW4
         yFFpLFCgdRklo9utS+sBT8y08YWnYZeq4RuOdoB6tzWy3/Ru+FtBho1xhPZL8WRzQRWP
         Ia2w==
X-Gm-Message-State: APjAAAXkSbA7bs3xtw3UzVtHEk21hlWZVzt74D+MRhTYHV8RWJqKW0nv
        IvJ4ZZGH9l08AYrlOZP9jHU=
X-Google-Smtp-Source: APXvYqzNnWUHwlJCYtRjPnM4tG/VteAkGiqthP9PjwfNMneBVu+24Yc772w0iwNmvSeJgfNHe1iDpg==
X-Received: by 2002:adf:f812:: with SMTP id s18mr3133864wrp.32.1564659400099;
        Thu, 01 Aug 2019 04:36:40 -0700 (PDT)
Received: from rric.localdomain (x4e365c6b.dyn.telefonica.de. [78.54.92.107])
        by smtp.gmail.com with ESMTPSA id l25sm54583654wme.13.2019.08.01.04.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Aug 2019 04:36:39 -0700 (PDT)
Date:   Thu, 1 Aug 2019 13:35:49 +0200
From:   Robert Richter <rric@kernel.org>
To:     Hanna Hawa <hhhawa@amazon.com>
Cc:     thor.thayer@linux.intel.com, bp@alien8.de, mchehab@kernel.org,
        james.morse@arm.com, morbidrsa@gmail.com, ralf@linux-mips.org,
        david.daney@cavium.com, andy.gross@linaro.org,
        david.brown@linaro.org, ckadabi@codeaurora.org,
        vnkgutta@codeaurora.org, jglauber@cavium.com,
        khuong@os.amperecomputing.com, dwmw@amazon.co.uk, benh@amazon.com,
        ronenk@amazon.com, talel@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [RFC 1/1] edac: Add a counter parameter for
 edac_device_handle_ue/ce()
Message-ID: <20190801113548.7leooh57gihixen5@rric.localdomain>
References: <1563187987-5847-1-git-send-email-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563187987-5847-1-git-send-email-hhhawa@amazon.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 15.07.19 13:53:07, Hanna Hawa wrote:
> Add a counter parameter in order to avoid losing errors count for edac
> device, the error count reports the number of errors reported by an edac
> device similar to the way MC_EDAC do.
> 
> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
> ---
>  drivers/edac/altera_edac.c      | 20 ++++++++++++--------
>  drivers/edac/amd8111_edac.c     |  6 +++---
>  drivers/edac/cpc925_edac.c      |  4 ++--
>  drivers/edac/edac_device.c      | 18 ++++++++++--------
>  drivers/edac/edac_device.h      |  8 ++++++--
>  drivers/edac/highbank_l2_edac.c |  4 ++--
>  drivers/edac/mpc85xx_edac.c     |  4 ++--
>  drivers/edac/mv64x60_edac.c     |  4 ++--
>  drivers/edac/octeon_edac-l2c.c  | 20 ++++++++++----------
>  drivers/edac/octeon_edac-pc.c   |  6 +++---
>  drivers/edac/qcom_edac.c        |  8 ++++----
>  drivers/edac/thunderx_edac.c    | 10 +++++-----
>  drivers/edac/xgene_edac.c       | 26 +++++++++++++-------------
>  13 files changed, 74 insertions(+), 64 deletions(-)

> diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
> index 1aaba74..cf1a1da 100644
> --- a/drivers/edac/edac_device.h
> +++ b/drivers/edac/edac_device.h
> @@ -290,23 +290,27 @@ extern struct edac_device_ctl_info *edac_device_del_device(struct device *dev);
>   *	perform a common output and handling of an 'edac_dev' UE event
>   *
>   * @edac_dev: pointer to struct &edac_device_ctl_info
> + * @error_count: number of errors of the same type
>   * @inst_nr: number of the instance where the UE error happened
>   * @block_nr: number of the block where the UE error happened
>   * @msg: message to be printed
>   */
>  extern void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
> -				int inst_nr, int block_nr, const char *msg);
> +				  u16 error_count, int inst_nr, int block_nr,
> +				  const char *msg);
>  /**
>   * edac_device_handle_ce():
>   *	perform a common output and handling of an 'edac_dev' CE event
>   *
>   * @edac_dev: pointer to struct &edac_device_ctl_info
> + * @error_count: number of errors of the same type
>   * @inst_nr: number of the instance where the CE error happened
>   * @block_nr: number of the block where the CE error happened
>   * @msg: message to be printed
>   */
>  extern void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,

How about renaming this to __edac_device_handle_ce() and then have 2
macros for:

 * edac_device_handle_ce() to keep old i/f.

 * edac_device_handle_ce_count(), with count parameter added.

Same for uncorrectable errors.

Code of other driver can be kept as it is then.

Thanks,

-Robert

> -				int inst_nr, int block_nr, const char *msg);
> +				  u16 error_count, int inst_nr, int block_nr,
> +				  const char *msg);
