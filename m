Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9436F1A661F
	for <lists+linux-edac@lfdr.de>; Mon, 13 Apr 2020 14:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbgDMMCa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Apr 2020 08:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbgDMMC3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 13 Apr 2020 08:02:29 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22595C03BC81;
        Mon, 13 Apr 2020 05:02:29 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a201so9291538wme.1;
        Mon, 13 Apr 2020 05:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=g/O468N0+e2tRsKFjrhvYQJivMOIkdyRPfvfIRlI7cs=;
        b=ojwONc8Z7k2dO3NqAqtxYI/NeOkT4ewz0t86tv53y/pIujj+hieQ3KLNk9ftfb3jmg
         XzOeklQQIeuJXOTvbulnoZcgspyaKep5/AGmp2QenkL3N07PZNCd1LJEbw3OM5SgktJK
         YSv3aD3xXkxvtcKzJ6Tt5fXxxEuwFMaDn6E4hHXKuYHHJXyvNej9i/AW8GqX7Fyxswq4
         U0QTwfSBeCgKBeiYOgx+SVuvitHnUPLDkzhF9rlr2BqY2b7qcXr/9j6UQrLGR9lQDAp4
         /f7DMQ5OSvk1h864+BPE2VRDLK5/uvmdME9pLzezv42cx4UEFFaKMJCYhIQN0vdxhLan
         QLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=g/O468N0+e2tRsKFjrhvYQJivMOIkdyRPfvfIRlI7cs=;
        b=mYUgWFs56lvKKQL8hpdEjtEO4vqrBZLy0GmbpNk8gD0YVWwvp91RHOlmGRB571PIXg
         YaFFgHm4z/BY47L8vghLLV8xQhkETyN5NVZC3pGZ+CSltrFM1o2y/wJmyz70xLxobEZu
         xojav1SIZC1DWEFlqTC6XMGGDiu77lpzNldjYGEmL8+MEg1pvlXFOCHZtNxjYkrQ+FWp
         uwzGkTRRww0KHC6bl5VC7OA7Bj+1w0BbdIWp62UwQyc4iQHG1b5DWua9/kRAWIPLgCV5
         SVZT1s8h0sTg9TWGYbau2lYZNrzV4ZwiQGujKw+JJkmCQCqKESqU97TX1wLFT+Nt8KwU
         zmlQ==
X-Gm-Message-State: AGi0PuaRpeiSrWPPCUGujRALR/xDwC0zQDaj0XJVTy3VbUguJbqXzm9A
        30dfBVv4jBLXZUW7+KF6UELowEuRQ5A=
X-Google-Smtp-Source: APiQypI/n5x0Dasbyjjtav2Kiy2dJHBsSLn588CFieJkVi6QTZqXPm+J/+su2U/4jAXj2iqawJdwFw==
X-Received: by 2002:a1c:bc02:: with SMTP id m2mr18086398wmf.60.1586779347766;
        Mon, 13 Apr 2020 05:02:27 -0700 (PDT)
Received: from felia ([2001:16b8:2da9:2f00:3165:1687:284f:4993])
        by smtp.gmail.com with ESMTPSA id a7sm14113305wmj.12.2020.04.13.05.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 05:02:27 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 13 Apr 2020 14:02:25 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@lst.de>, Borislav Petkov <bp@suse.de>,
        Yash Shah <yash.shah@sifive.com>, linux-edac@vger.kernel.org,
        Sebastian Duda <sebastian.duda@fau.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: place sifive_l2_cache.c only in SIFIVE
 DRIVERS
In-Reply-To: <20200413114702.6372-1-lukas.bulwahn@gmail.com>
Message-ID: <alpine.DEB.2.21.2004131401190.7282@felia>
References: <20200413114702.6372-1-lukas.bulwahn@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On Mon, 13 Apr 2020, Lukas Bulwahn wrote:

> Commit 9209fb51896f ("riscv: move sifive_l2_cache.c to drivers/soc") moved
> arch/riscv/mm/sifive_l2_cache.c to drivers/soc/sifive/sifive_l2_cache.c
> and adjusted the MAINTAINERS EDAC-SIFIVE entry but slipped in a mistake.
> 
> Since then, ./scripts/get_maintainer.pl --self-test complains:
> 
>   warning: no file matches F: drivers/soc/sifive_l2_cache.c
> 
> Boris suggested that sifive_l2_cache.c is considered part of the SIFIVE
> DRIVERS, not part of EDAC-SIFIVE. So, we can simply drop this entry, and
> by the sifive keyword pattern in SIFIVE PATTERNS, it is automatically part
> of the SIFIVE DRIVERS.
> 
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
> Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Paul, please pick this patch.
> 
> v1: https://lore.kernel.org/lkml/20200304144045.15060-1-lukas.bulwahn@gmail.com/
>   - was not picked up.
> 
> v1-resend: https://lore.kernel.org/lkml/20200413073447.9284-1-lukas.bulwahn@gmail.com/
> 
> v2: reworked based on Boris comment; applies on v5.7-rc1
> 
> 
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e64e5db31497..e28676766b26 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6172,7 +6172,7 @@ M:	Yash Shah <yash.shah@sifive.com>
>  L:	linux-edac@vger.kernel.org
>  S:	Supported
>  F:	drivers/edac/sifive_edac.c
> -F:	drivers/soc/sifive_l2_cache.c
> +F:	drivers/soc/sifive/sifive_l2_cache.c
>  
>  EDAC-SKYLAKE
>  M:	Tony Luck <tony.luck@intel.com>
> -- 
> 2.17.1
> 
> 

Please ignore this patch. I accidently sent this patch out too quickly.

Please consider and pick this PATCH v3 instead:

https://lore.kernel.org/lkml/20200413115255.7100-1-lukas.bulwahn@gmail.com/


Lukas
