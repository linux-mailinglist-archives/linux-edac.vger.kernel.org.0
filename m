Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1DF77D438
	for <lists+linux-edac@lfdr.de>; Tue, 15 Aug 2023 22:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238302AbjHOUgL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Aug 2023 16:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238466AbjHOUf5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Aug 2023 16:35:57 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099CE1FFB
        for <linux-edac@vger.kernel.org>; Tue, 15 Aug 2023 13:35:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-688769faa09so492305b3a.2
        for <linux-edac@vger.kernel.org>; Tue, 15 Aug 2023 13:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692131747; x=1692736547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mPFfFDm5pA4v6nMeP5/NIkRUW1O55g9MR5VmXpYuFuI=;
        b=fz6uOF6u1h7s51c8hVMD5tC9JikgTGuTtZxT+e3akqgHhyMlEwzc0/VcD6AH5DbH/9
         n0GhZLOo5UfdpIEi6/UYqLwEeYwYZaZ/jVodz1YaK9FIUXCiPMi2FCyyfrf0at6iLwz4
         y587/2iYWyZqFaU+7RvrJKxUdiivt1OnxfGUhyMAao8evBzJcZ1OLU7C9xbLI+VRqMT6
         jdKibd3EDMF5pAruff9HaqTYBtPBYo5SEHUUmcdbxcnmx3Gzh5o6bpwLGIBXnZG4//Mm
         +0d3ANtSgno3kZVRNdMGOklYlPBmFp5/rkbs7DT4ZdTAjOdphjucegt7MKyuaKnTDX78
         cxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692131747; x=1692736547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPFfFDm5pA4v6nMeP5/NIkRUW1O55g9MR5VmXpYuFuI=;
        b=BsT9kGK+fIP+Fh2gYR//Jr1pQOfGm9hskZEneTY7ja3qisYNmigcdHycQ+cNgZb6ZR
         Pc75ypGa4Q5jF1BXjFEkWb82ki+G6S61UcCndOf8oA/czftZxEA8j/cgsymNYFpPArJV
         htGfjHSVVEJt33y34i68daObMX9FaYfkhTLUOdzPxYIzcQtE4h80aPdKa8fHD+5qb6Nx
         ASU8SrxvyCTaYOIK+C1+4abuXYeeJoPQyjd9hqCKjpgt0yyoxDwOfYNF6BiAVIA8if6H
         hkVIjOxxJKEMEtdqe+7in4IySdsAin6j4ryVuXnrD9DK4csm692c5goEmzwPf0M859tq
         jDSA==
X-Gm-Message-State: AOJu0Yz9NJ1GvlHzGkG8rpmPi7y7+//vGhs+sG3ZZKcZAkgev7O4e5E9
        jGF1w+UQDBy+i9jVz5bchDg=
X-Google-Smtp-Source: AGHT+IHMUzArXSJZhBKI7d0BvU5Evh2xdN2u3cyKQuhPgoH9VUo0or3xM5qLOWbWIOVq10pn3rjwNg==
X-Received: by 2002:a05:6a20:428a:b0:13d:d5bd:7593 with SMTP id o10-20020a056a20428a00b0013dd5bd7593mr14663114pzj.12.1692131747470;
        Tue, 15 Aug 2023 13:35:47 -0700 (PDT)
Received: from atom0118 ([2405:201:c009:58e9:db85:3caf:1429:e455])
        by smtp.gmail.com with ESMTPSA id x52-20020a056a000bf400b006870c50efaesm9785846pfu.9.2023.08.15.13.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 13:35:47 -0700 (PDT)
Date:   Wed, 16 Aug 2023 02:05:19 +0530
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     shubhrajyoti.datta@amd.com, sai.krishna.potthuri@amd.com,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        bp@alien8.de, tony.luck@intel.com, michal.simek@amd.com,
        shuah@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v1] drivers: edac: zynqmp_edac: Updates return value check
Message-ID: <20230815203519.GB51427@atom0118>
References: <20230806130514.159102-1-atulpant.linux@gmail.com>
 <2023080631-salon-banter-31b7@gregkh>
 <20230807023104.GA4030@atom0118>
 <2023080727-wildly-veal-c0fd@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023080727-wildly-veal-c0fd@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Aug 07, 2023 at 08:01:56AM +0200, Greg KH wrote:
> On Mon, Aug 07, 2023 at 08:01:04AM +0530, Atul Kumar Pant wrote:
> > On Sun, Aug 06, 2023 at 03:37:01PM +0200, Greg KH wrote:
> > > On Sun, Aug 06, 2023 at 06:35:14PM +0530, Atul Kumar Pant wrote:
> > > > Updating the check of return value from edac_debugfs_create_dir
> > > > to use IS_ERR.
> > > > 
> > > > Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> > > > ---
> > > >  drivers/edac/zynqmp_edac.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/edac/zynqmp_edac.c b/drivers/edac/zynqmp_edac.c
> > > > index ac7d1e0b324c..cefbbafb945e 100644
> > > > --- a/drivers/edac/zynqmp_edac.c
> > > > +++ b/drivers/edac/zynqmp_edac.c
> > > > @@ -351,7 +351,7 @@ static void setup_debugfs(struct edac_device_ctl_info *edac_dev)
> > > >  	struct edac_priv *priv = edac_dev->pvt_info;
> > > >  
> > > >  	priv->debugfs_dir = edac_debugfs_create_dir("ocm");
> > > > -	if (!priv->debugfs_dir)
> > > > +	if (IS_ERR(priv->debugfs_dir))
> > > >  		return;
> > > 
> > > Again, not correct, sorry.  Please do not make these types of changes.
> > > 
> > > Why do you feel this is needed at all?
> > > 
> >     edac_debugfs_create_dir uses debugfs_create_dir that return ERR_PTR.
> >     Hence to check the return value by this function I changed null
> >     comparison with IS_ERR.
> 
> But that's not needed at all, right?
> 
> As this check has not ever really worked, why check it at all?

	I'll fix this in a new patch
> 
> greg k-h
