Return-Path: <linux-edac+bounces-417-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342DF844732
	for <lists+linux-edac@lfdr.de>; Wed, 31 Jan 2024 19:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ED0BB26DE7
	for <lists+linux-edac@lfdr.de>; Wed, 31 Jan 2024 18:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD4737E;
	Wed, 31 Jan 2024 18:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="inrk+6vE"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485A3210E2
	for <linux-edac@vger.kernel.org>; Wed, 31 Jan 2024 18:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706726007; cv=none; b=r21zKgiuBzt/ILC+SsQrqIHUvE5SovhKPNyCirCo5E6lA1uCjvMXy2tYMXuIGHcnZZ5Mel2JkURHqy/bcosDO1VRen+TVPdfY/jhYWCD3G27k4W5NTEx2qyPjgty8h+u8ruIXnvxv0ztIb6I6aLPhvTtST+nNT6Vnz8+FxGIY64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706726007; c=relaxed/simple;
	bh=wms8dqsG50J0wVf/I/hlZZIggxbsPk38xYEL8f+Kj0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfWlyJnkaGc+X2KTTvzY0fifg2bAyfUSc/hFgOkcYtVU1gmOHpvHXhMhFaQJ5uoH4fwQwTaagu8wfKK4Vk+7T2AYBBG61o0ug2sDKf/K8dPqd55GURI23HJlx+UmqHerORe9O6Y5hbD2gx7TOrro2O/fjV/2cFldVOGTwZKCGuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=inrk+6vE; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40fb3e278adso1017425e9.2
        for <linux-edac@vger.kernel.org>; Wed, 31 Jan 2024 10:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706726003; x=1707330803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GFRpxGZ95W+UgrhlPQVWzxSxRcvwPmQrYeDU1AR9M/M=;
        b=inrk+6vEXLJ4m2V4wrH9nv4MueBO3tehWrSBMsDXdJ1oErPRh7P2g71XKDVGk0A+FK
         Jrc8/Vt1cqKGcw9Mr76acUbcZ7Klu/x616TfFqeijDetVasbXvivP+SrPNY9/Kojfcw5
         AKdbA0jKBOIHhWID+9bDsQYYDPsxUBYd8yg+no382EIAQtq4idwdZscBQUY3yiur9ftu
         6X5Hbyl3fcBIej41HsbjM73uPyoNHYTX0JUXn/iG8OJlvLwhBmWoz4AV1wucZj4trG6M
         5id+OrILZd9eZbk0UmlekTc/LGDnbwxo8lvuy69ObiZiZ2okJZwVsLV19gvkFInQJk63
         Wo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706726003; x=1707330803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFRpxGZ95W+UgrhlPQVWzxSxRcvwPmQrYeDU1AR9M/M=;
        b=gGNkgIAe2XwGYC35IDqgDEG90WJWnWgbCbv3SGxGH8Pq+giPCj/U8P5jbk9rUmBn0c
         M3dneCIkEQs3mCFNwen7Drd9vcx64YihZN5aj0UgZPvL36S2LaHuriHKOXXGehnx2y60
         9mUrf14xDE+O6keELPdKdr6HnIStpup1izSOmmJEUD8WPEgNsAoIPXXosFtNF7FSrhSK
         +fPd11hRtdMmzNh89d525YmiWXo+3RYiRb3+pUr3YeIButvmsvhP6Ck0wcR3FJsdH7yf
         fnF+3Eydm0/0eB0XeMeIGR4msgIv2gaBFzlo+wCha8dKIYgpvrbERlaOM2ENEzvyixMX
         eQFg==
X-Gm-Message-State: AOJu0Yz3A38LGMfJBK4t0zWea+JbCGXqWei4xjbqUv3O/1DNruWDw7K6
	5W1b4rKgrsgpGh8IdTjPxEWXK2I0FIRq6fgmBMVPswp0fskSQCdFfqM7PLagelxWzvuCEkAaSCs
	c
X-Google-Smtp-Source: AGHT+IFqHzYJ+PK5ES1FSKSmm/JTSZ0f7jza9CVI9jOb3UuP+czjKGbYFaGV+FGpIW8bRCvt5dX4nQ==
X-Received: by 2002:a05:600c:1c9c:b0:40e:88be:ec58 with SMTP id k28-20020a05600c1c9c00b0040e88beec58mr1773905wms.31.1706726003527;
        Wed, 31 Jan 2024 10:33:23 -0800 (PST)
Received: from localhost ([102.140.226.10])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c459100b0040e527602c8sm2298363wmo.9.2024.01.31.10.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 10:33:23 -0800 (PST)
Date: Wed, 31 Jan 2024 21:33:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, muralidhara.mk@amd.com,
	linux-edac@vger.kernel.org
Subject: Re: [bug report] RAS/AMD/ATL: Add MI300 support
Message-ID: <3d20cb1e-e116-416a-ac1b-3e4226c85e74@moroto.mountain>
References: <18bb00a0-5742-47a5-9dd6-c35c164114e2@moroto.mountain>
 <20240131085638.GBZboLRr6jsZhqwjfP@fat_crate.local>
 <1b3a758c-7928-4486-b63a-bee977d99913@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b3a758c-7928-4486-b63a-bee977d99913@amd.com>

On Wed, Jan 31, 2024 at 10:45:55AM -0500, Yazen Ghannam wrote:
> On 1/31/2024 3:56 AM, Borislav Petkov wrote:
> > + Yazen.
> > 
> > On Wed, Jan 31, 2024 at 11:24:37AM +0300, Dan Carpenter wrote:
> > > Hello Muralidhara M K,
> > > 
> > > The patch 453f0ae79732: "RAS/AMD/ATL: Add MI300 support" from Jan 28,
> > > 2024 (linux-next), leads to the following (unpublished) Smatch static
> > > checker warning:
> > > 
> > > drivers/ras/amd/atl/dehash.c:389 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_4k'
> > > drivers/ras/amd/atl/dehash.c:394 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_64k'
> > > drivers/ras/amd/atl/dehash.c:396 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_2M'
> > > drivers/ras/amd/atl/dehash.c:398 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_1G'
> > > drivers/ras/amd/atl/dehash.c:400 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_1T'
> > > drivers/ras/amd/atl/dehash.c:402 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_1T'
> > > drivers/ras/amd/atl/dehash.c:419 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_64k'
> > > drivers/ras/amd/atl/dehash.c:421 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_2M'
> > > drivers/ras/amd/atl/dehash.c:423 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_1G'
> > > drivers/ras/amd/atl/dehash.c:425 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_1T'
> > > 
> > > drivers/ras/amd/atl/dehash.c
> > >      357 static int mi300_dehash_addr(struct addr_ctx *ctx)
> > >      358 {
> > >      359         bool hash_ctl_4k, hash_ctl_64k, hash_ctl_2M, hash_ctl_1G, hash_ctl_1T;
> > >      360         bool hashed_bit, intlv_bit, test_bit;
> > >      361         u8 num_intlv_bits, base_bit, i;
> > >      362
> > >      363         if (!map_bits_valid(ctx, 8, 8, 4, 1))
> > >      364                 return -EINVAL;
> > >      365
> > >      366         hash_ctl_4k  = FIELD_GET(DF4p5_HASH_CTL_4K, ctx->map.ctl);
> > > 
> > > hash_ctl_4k is bool.
> 
> The bool will be true or false depending on if the appropriate bit is set in ctx->map.ctl.
> 
> Is this not correct?
> 
> For context, the intent is to use bool type for variables that contain a single bit.
> 
> > > 
> > >      367         hash_ctl_64k = FIELD_GET(DF4_HASH_CTL_64K,  ctx->map.ctl);
> > >      368         hash_ctl_2M  = FIELD_GET(DF4_HASH_CTL_2M,   ctx->map.ctl);
> > >      369         hash_ctl_1G  = FIELD_GET(DF4_HASH_CTL_1G,   ctx->map.ctl);
> > >      370         hash_ctl_1T  = FIELD_GET(DF4p5_HASH_CTL_1T, ctx->map.ctl);
> > >      371
> > >      372         /* Channel bits */
> > >      373         num_intlv_bits = ilog2(ctx->map.num_intlv_chan);
> > >      374
> > >      375         for (i = 0; i < num_intlv_bits; i++) {
> > >      376                 base_bit = 8 + i;
> > >      377
> > >      378                 /* COH_ST_Select[4] jumps to a base bit of 14. */
> > >      379                 if (i == 4)
> > >      380                         base_bit = 14;
> > >      381
> > >      382                 intlv_bit = BIT_ULL(base_bit) & ctx->ret_addr;
> 
> Since intlv_bit is bool, I expect it will be set to 'true' if the right-hand-side is
> non-zero. So shifting and !!(x) isn't necessary. Is this not correct?
> 
> > >      383
> > >      384                 hashed_bit = intlv_bit;
> > >      385
> > >      386                 /* 4k hash bit only applies to the first 3 bits. */
> > >      387                 if (i <= 2) {
> > >      388                         test_bit    = BIT_ULL(12 + i) & ctx->ret_addr;
> > > 
> > > test_bit is BIT(12 - 14).
> > 
> > test_bit is (BIT(14) & ctx->ret_addr), if i == 2, for example.
> > 
> > If ctx->ret_addr has bit 14 set, test_bit will be 1.
> > 
> > I'm confused.
> > 
> > Leaving in the rest for Yazen.
> > 
> > > 
> > > --> 389                         hashed_bit ^= test_bit & hash_ctl_4k;
> > > 
> > > BIT(12) & true is always false.
> > > 
> 
> 'test_bit' can be 'true' or 'false depending on the value of the input ctx->ret_addr.
> And 'hash_ctl_4k' can be 'true' or 'false' depending on the setting in a control
> hardware register.
> 
> Am I misunderstanding how the bool type can be used? Apologies if my assumptions are
> incorrect.
> 

Oh, sorry, I hadn't seen that test_bit was also declared as bool.
This is a bug in Smatch.  I will fix it.


> Since a bool is stored as a u8, is it possible that bits[7:1] can be set? And will bool
> operations only use bit[0]? This would break my assumptions regarding the bitmask uses.

No, only bool can only be true/false (BIT(0)).  There was just a bug in
Smatch and I misread the code.  Sorry for that noise.

regards,
dan carpenter


