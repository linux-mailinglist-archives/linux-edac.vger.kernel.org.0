Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D295771856
	for <lists+linux-edac@lfdr.de>; Mon,  7 Aug 2023 04:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjHGCbO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 6 Aug 2023 22:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjHGCbO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 6 Aug 2023 22:31:14 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287CD170A
        for <linux-edac@vger.kernel.org>; Sun,  6 Aug 2023 19:31:13 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686b9964ae2so2717203b3a.3
        for <linux-edac@vger.kernel.org>; Sun, 06 Aug 2023 19:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691375472; x=1691980272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8MtUmDOT4hbgkhome0dArLibfOqFr9fyGVLclTZcR/I=;
        b=OILhHfS9+nFKQjvYoPSlglBArsK0CU0hgxDWXWIYD0hq+yRtCTi79PUiN349SjmDsH
         ZeNO9vnryPF35q//Xnjwmy3hynss0CgOR5eOfyRsfY+trmKb2rJ/aVkHOd3w6oJmK4pO
         9qaaUaSoiY2cNkW0GHJB194icWWsem6Fnn62zVtxo6xHXmUDMKbqGe1LyGSptnjmdw1T
         YXMYzxGLCDRCAubQexezlwrCVM28uA5BSUCBiTiqwXZnX+q+kLs4CfyNPjLhy5Qtz94K
         Dip8DPK0lVb3JeSIeZUPqKATFS/8RP/yPAPOLv0R9PmSRDBLCqs1rRUfmirFwLqn8KE7
         pvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691375472; x=1691980272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MtUmDOT4hbgkhome0dArLibfOqFr9fyGVLclTZcR/I=;
        b=K49gOftZijyUgpHFZOBmWIWWWMOm2kD6npJZu1WRmVvOQPnQPpfE+Na0JnUsv/hMHm
         gCwGBfmljnpmI2kLOAtdQX3NzQFGq5dpsXED6NuMTvJIcsCulXWw5qCmd0ykFAUyXOM1
         lBVfDiaEPqd/U3IS6Al3yYUnWenxc68mF+Pa/pIlPVRKTV2SqVbgO6yAo2UOeF306bip
         Vv2GCI+mONZKSb+aw4ElkqKi+CrAo/FdtDljYgkHLuLOWXdtUaJoVluSq2BQXIok2GyQ
         7GP6BbohkXg7+qbkzRQ3gJvkyfU6d725325MSy0MWo9e5rWzf2usaHeqwVTqt8pR7pSd
         cQYA==
X-Gm-Message-State: AOJu0YzpoASd3B75z/2gRDeFCjWphrNtNpikt/tMHO0Y/KTekxJYjJUA
        Wgw2bhPKyS051ais8p+OVO/bltDeteY=
X-Google-Smtp-Source: AGHT+IHWDWtqlShThH+qeIRbWnFU4LQo1cMNU8kGLBUq5GfaPYHra+rzPBWAuv4AA57BrmNeSeggyA==
X-Received: by 2002:a05:6a20:160b:b0:133:e3e3:dc07 with SMTP id l11-20020a056a20160b00b00133e3e3dc07mr8610513pzj.49.1691375472581;
        Sun, 06 Aug 2023 19:31:12 -0700 (PDT)
Received: from atom0118 ([2405:201:c009:58e9:e6a4:a0f3:7393:fde0])
        by smtp.gmail.com with ESMTPSA id r1-20020a62e401000000b006877a2e6285sm4944819pfh.128.2023.08.06.19.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 19:31:12 -0700 (PDT)
Date:   Mon, 7 Aug 2023 08:01:04 +0530
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     shubhrajyoti.datta@amd.com, sai.krishna.potthuri@amd.com,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        bp@alien8.de, tony.luck@intel.com, michal.simek@amd.com,
        shuah@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v1] drivers: edac: zynqmp_edac: Updates return value check
Message-ID: <20230807023104.GA4030@atom0118>
References: <20230806130514.159102-1-atulpant.linux@gmail.com>
 <2023080631-salon-banter-31b7@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023080631-salon-banter-31b7@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Aug 06, 2023 at 03:37:01PM +0200, Greg KH wrote:
> On Sun, Aug 06, 2023 at 06:35:14PM +0530, Atul Kumar Pant wrote:
> > Updating the check of return value from edac_debugfs_create_dir
> > to use IS_ERR.
> > 
> > Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> > ---
> >  drivers/edac/zynqmp_edac.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/edac/zynqmp_edac.c b/drivers/edac/zynqmp_edac.c
> > index ac7d1e0b324c..cefbbafb945e 100644
> > --- a/drivers/edac/zynqmp_edac.c
> > +++ b/drivers/edac/zynqmp_edac.c
> > @@ -351,7 +351,7 @@ static void setup_debugfs(struct edac_device_ctl_info *edac_dev)
> >  	struct edac_priv *priv = edac_dev->pvt_info;
> >  
> >  	priv->debugfs_dir = edac_debugfs_create_dir("ocm");
> > -	if (!priv->debugfs_dir)
> > +	if (IS_ERR(priv->debugfs_dir))
> >  		return;
> 
> Again, not correct, sorry.  Please do not make these types of changes.
> 
> Why do you feel this is needed at all?
> 
    edac_debugfs_create_dir uses debugfs_create_dir that return ERR_PTR.
    Hence to check the return value by this function I changed null
    comparison with IS_ERR.

> thanks,
> 
> greg k-h
