Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2F726098C
	for <lists+linux-edac@lfdr.de>; Tue,  8 Sep 2020 06:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgIHE25 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 8 Sep 2020 00:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgIHE24 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 8 Sep 2020 00:28:56 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558DFC061573;
        Mon,  7 Sep 2020 21:28:54 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id cy2so7213733qvb.0;
        Mon, 07 Sep 2020 21:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SktCofgYUSpT84xC9qw3Ohre3yug4nlJxNHub1OTSd4=;
        b=VM+Up9rJrGtlwisHkT6qGKrBf9+/wgo3tfB/NfC3RKb/YUh+8C2Ym2qDz9CSt+IBL+
         +f34SBacBMp5iAJM30F8UysVmkBe/UIk03rqw/kPCbAHMMYB2gk7HiW8DPxDDCA1vxKd
         ViRslQfsTi+5irHw0NkWlXbX3QWY1nGXXmZQcQTgZzB/8dklva0zsIWy7uuL5qo+9vvG
         4jOy3aL0Xyxy/1F3d5FJbjcjolV8kvBnCR2Jw/r9ufVGyrzg5kX4Vzr9i61TN45uPm/O
         drfkzebaNIpthTFEs7r7bdCT5LDzljvvsMNoBEHIYeCZp+LVc5SmuJ7QHQitRQDbeCFY
         rAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SktCofgYUSpT84xC9qw3Ohre3yug4nlJxNHub1OTSd4=;
        b=tkcq5lbQt94ieRjA0TtF/JXAYQLqJ7j8myBM+QsPvZL3UjO9+mE2tRCkfHQrULVYuu
         1E8TvB/sSu6VkvFffuLrvxYK2ECVovmZxd0YBJSeJWbFzz5cgrlQe+SJuF9tIN9sjsNX
         2Xhh2mHILXap+T4irbiUUxo8xQsDuCjmGAahBqb7UWq06HiM1YbOjSvXrs6jL60LOW05
         nMB5uv9azNqtk1O31MyNdoJcSqdci6FQh0m2S+nrRxrJwPzI0FTFSUqClZl0z/GYAbul
         bpA3ApJkDkbcPWK6SUM73Nb4/4EeNwi5568G12bvs8hnPzcEPRsjIOfs6++GeJOfYn7Q
         2QUA==
X-Gm-Message-State: AOAM532ppwLccf4uMUnm4oppwf2RvPGZ8UqDbiaS6ZO3NWEKF3XyAxAo
        X+ZMKn5Izpad4R5Aptfz3EQ=
X-Google-Smtp-Source: ABdhPJxaxdXlFDVxInJttdS2pjiM1dSMtP+9V7c4wvr7v/jLytz6AwlZjLJz6z5Em8rYZ9JcPmRKFQ==
X-Received: by 2002:ad4:4d42:: with SMTP id m2mr22019223qvm.163.1599539333464;
        Mon, 07 Sep 2020 21:28:53 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id e10sm13376346qtq.59.2020.09.07.21.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 21:28:52 -0700 (PDT)
Date:   Mon, 7 Sep 2020 21:28:51 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     trix@redhat.com
Cc:     tony.luck@intel.com, qiuxu.zhuo@intel.com, bp@alien8.de,
        mchehab@kernel.org, james.morse@arm.com, rric@kernel.org,
        ndesaulniers@google.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] EDAC: sb_edac: simplify switch statement
Message-ID: <20200908042851.GA1422621@ubuntu-n2-xlarge-x86>
References: <20200907153225.7294-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907153225.7294-1-trix@redhat.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Sep 07, 2020 at 08:32:25AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> clang static analyzer reports this problem
> 
> sb_edac.c:959:2: warning: Undefined or garbage value
>   returned to caller
>         return type;
>         ^~~~~~~~~~~
> 
> This is a false positive.
> 
> However by initializing the type to DEV_UNKNOWN the 3 case can be
> removed from the switch, saving a comparison and jump.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Some maintainers have a preference for a default case statement but
presumably this case statement has been cutting it as is so:

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  drivers/edac/sb_edac.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
> index 68f2fe4df333..93daa4297f2e 100644
> --- a/drivers/edac/sb_edac.c
> +++ b/drivers/edac/sb_edac.c
> @@ -939,12 +939,9 @@ static enum dev_type sbridge_get_width(struct sbridge_pvt *pvt, u32 mtr)
>  
>  static enum dev_type __ibridge_get_width(u32 mtr)
>  {
> -	enum dev_type type;
> +	enum dev_type type = DEV_UNKNOWN;
>  
>  	switch (mtr) {
> -	case 3:
> -		type = DEV_UNKNOWN;
> -		break;
>  	case 2:
>  		type = DEV_X16;
>  		break;
> -- 
> 2.18.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200907153225.7294-1-trix%40redhat.com.
