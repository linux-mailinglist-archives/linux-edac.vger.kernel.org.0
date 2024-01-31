Return-Path: <linux-edac+bounces-411-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D9D8438DB
	for <lists+linux-edac@lfdr.de>; Wed, 31 Jan 2024 09:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F42228B8FC
	for <lists+linux-edac@lfdr.de>; Wed, 31 Jan 2024 08:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3ED5D750;
	Wed, 31 Jan 2024 08:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yt/SuznB"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D9757895
	for <linux-edac@vger.kernel.org>; Wed, 31 Jan 2024 08:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689484; cv=none; b=QfdVBo8FyMVpn1mmwFXE/+zxVwBCSFrAZ/BdRdeZnliYoTjVFFNoNMexBHHX6XLUVoPIy4uIRwqKbkJEi5xJSFgmXOMsIsugB6np3KpBSugq7H7Gn9mtvbdF8Iqf3bRt+I+Amj5Oe6C1QmnVpeXsGlAsRd6+0IeUlZpdk+aJK1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689484; c=relaxed/simple;
	bh=2MrAiFNhX0Xnqf4sINJcVQ4O2gZvMDzklpLRB6MpcAM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dgCYLCAkhWe7WjODSjHpCyxE0zK16UN8jbc+FcxMLKEFVocucNGLLSmi0Iamqdq6AgQP9jXDh4C1Ldnlm6x/BLMGy4iuKhcew+Jjgwipmr7FsR7FqgeDVFYO/Fycm0MYCLkT03uX9peGoAsAzF31qu+5nPj/B0YL5Ee/u2Mt4W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yt/SuznB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40ef6f10b56so22936465e9.2
        for <linux-edac@vger.kernel.org>; Wed, 31 Jan 2024 00:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706689481; x=1707294281; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TELNqIqDO68pObWbYkpMEhYMzVdkt9FetqFDPQNhUeY=;
        b=yt/SuznB/HGRy1jlrMzTTbrSdc5o8QFOXPRmHXGeRJ9tgxVm11/Fztf//Kf/9Ykiz4
         2cZOM7HwDl2qZVWsaHFtg4q09kpr4/9OSYF6GFi6CM6XWstSQFaWQ+PrDeJf4gR37nVk
         ePEWgnS23iB/cvbH5J/suenFPujbQZenc6tsc5Wm0jB3FdZ8AVpl9saPHEVZsP+556yr
         6Yn+pXov6muJiE5pla0sRuJxGXgNWQ/MvcxoHmzjndcXWgWcYrsnShMhJ9EVTuWij6kk
         udI9QKTV4oEEJg2UcMcwYLUtsKYSgQR4nRjV+3Ds1p3s6J51i4TL29jzuX743duK21kG
         IY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706689481; x=1707294281;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TELNqIqDO68pObWbYkpMEhYMzVdkt9FetqFDPQNhUeY=;
        b=tHzLAhAwPlBOFN9tkyfZMZZ3rb4dFZAS+fEA5DROrDWJuEpzOFLqkKEw/kikfd6AsN
         Iy4o9peU6vmngNG1gWYjzoHIUZSe7+fgHcQcpXEpDLETHPWjgyAwPB+kz1Q0y72ZUUNL
         Gx8Mw4aW0y3rOCyL9wjwMTtnYGXD7GJgWI6MNY78JaH3fw878HU2TxZ1RKyXEWafZOe0
         O0MwqWJlQBmcHzatwk/aQPQ48+z0oXnZko//JgEcLEEdQIdfXfLKgXP+tRWQw79UZgWF
         7XdlwX6BTa9j5DEFe+P2DgQ4hCjQQwx5q4yGVVxwCvwaQLyNHdE685dEcxQFq4QREJ5+
         BnsQ==
X-Gm-Message-State: AOJu0Ywm2J2wBx1MncwAQqYFemqAT6Ad3wL+3SmT0haYl+LUd5HAsUdU
	D5vQP8BcWlDlLTtmWS6Uf5FraTUPUL3nJHX4FrLl3MGlPfQ6dx1mF+ydKpANGOc=
X-Google-Smtp-Source: AGHT+IFAsSPJ7cnW4lmfaS4uHvYG8wjsizWJk/RNR6LZY/clm8E0+oQo97hClGa5IW3yIlKYLHSIhA==
X-Received: by 2002:adf:e487:0:b0:337:cce9:90c0 with SMTP id i7-20020adfe487000000b00337cce990c0mr534195wrm.67.1706689481008;
        Wed, 31 Jan 2024 00:24:41 -0800 (PST)
Received: from localhost ([102.140.226.10])
        by smtp.gmail.com with ESMTPSA id cw7-20020a056000090700b0033afcb5b5d2sm3278135wrb.80.2024.01.31.00.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 00:24:40 -0800 (PST)
Date: Wed, 31 Jan 2024 11:24:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: muralidhara.mk@amd.com
Cc: linux-edac@vger.kernel.org
Subject: [bug report] RAS/AMD/ATL: Add MI300 support
Message-ID: <18bb00a0-5742-47a5-9dd6-c35c164114e2@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Muralidhara M K,

The patch 453f0ae79732: "RAS/AMD/ATL: Add MI300 support" from Jan 28,
2024 (linux-next), leads to the following (unpublished) Smatch static
checker warning:

drivers/ras/amd/atl/dehash.c:389 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_4k'
drivers/ras/amd/atl/dehash.c:394 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_64k'
drivers/ras/amd/atl/dehash.c:396 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_2M'
drivers/ras/amd/atl/dehash.c:398 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_1G'
drivers/ras/amd/atl/dehash.c:400 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_1T'
drivers/ras/amd/atl/dehash.c:402 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_1T'
drivers/ras/amd/atl/dehash.c:419 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_64k'
drivers/ras/amd/atl/dehash.c:421 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_2M'
drivers/ras/amd/atl/dehash.c:423 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_1G'
drivers/ras/amd/atl/dehash.c:425 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_1T'

drivers/ras/amd/atl/dehash.c
    357 static int mi300_dehash_addr(struct addr_ctx *ctx)
    358 {
    359         bool hash_ctl_4k, hash_ctl_64k, hash_ctl_2M, hash_ctl_1G, hash_ctl_1T;
    360         bool hashed_bit, intlv_bit, test_bit;
    361         u8 num_intlv_bits, base_bit, i;
    362 
    363         if (!map_bits_valid(ctx, 8, 8, 4, 1))
    364                 return -EINVAL;
    365 
    366         hash_ctl_4k  = FIELD_GET(DF4p5_HASH_CTL_4K, ctx->map.ctl);

hash_ctl_4k is bool.

    367         hash_ctl_64k = FIELD_GET(DF4_HASH_CTL_64K,  ctx->map.ctl);
    368         hash_ctl_2M  = FIELD_GET(DF4_HASH_CTL_2M,   ctx->map.ctl);
    369         hash_ctl_1G  = FIELD_GET(DF4_HASH_CTL_1G,   ctx->map.ctl);
    370         hash_ctl_1T  = FIELD_GET(DF4p5_HASH_CTL_1T, ctx->map.ctl);
    371 
    372         /* Channel bits */
    373         num_intlv_bits = ilog2(ctx->map.num_intlv_chan);
    374 
    375         for (i = 0; i < num_intlv_bits; i++) {
    376                 base_bit = 8 + i;
    377 
    378                 /* COH_ST_Select[4] jumps to a base bit of 14. */
    379                 if (i == 4)
    380                         base_bit = 14;
    381 
    382                 intlv_bit = BIT_ULL(base_bit) & ctx->ret_addr;
    383 
    384                 hashed_bit = intlv_bit;
    385 
    386                 /* 4k hash bit only applies to the first 3 bits. */
    387                 if (i <= 2) {
    388                         test_bit    = BIT_ULL(12 + i) & ctx->ret_addr;

test_bit is BIT(12 - 14).

--> 389                         hashed_bit ^= test_bit & hash_ctl_4k;

BIT(12) & true is always false.

    390                 }
    391 
    392                 /* Use temporary 'test_bit' value to avoid Sparse warnings. */
    393                 test_bit    = BIT_ULL(15 + i) & ctx->ret_addr;
    394                 hashed_bit ^= test_bit & hash_ctl_64k;
    395                 test_bit    = BIT_ULL(22 + i) & ctx->ret_addr;
    396                 hashed_bit ^= test_bit & hash_ctl_2M;
    397                 test_bit    = BIT_ULL(29 + i) & ctx->ret_addr;
    398                 hashed_bit ^= test_bit & hash_ctl_1G;
    399                 test_bit    = BIT_ULL(36 + i) & ctx->ret_addr;
    400                 hashed_bit ^= test_bit & hash_ctl_1T;
    401                 test_bit    = BIT_ULL(43 + i) & ctx->ret_addr;
    402                 hashed_bit ^= test_bit & hash_ctl_1T;
    403 
    404                 if (hashed_bit != intlv_bit)
    405                         ctx->ret_addr ^= BIT_ULL(base_bit);
    406         }
    407 
    408         /* Die bits */
    409         num_intlv_bits = ilog2(ctx->map.num_intlv_dies);
    410 
    411         for (i = 0; i < num_intlv_bits; i++) {
    412                 base_bit = 12 + i;
    413 
    414                 intlv_bit = BIT_ULL(base_bit) & ctx->ret_addr;
    415 
    416                 hashed_bit = intlv_bit;
    417 
    418                 test_bit    = BIT_ULL(20 + i) & ctx->ret_addr;
    419                 hashed_bit ^= test_bit & hash_ctl_64k;
    420                 test_bit    = BIT_ULL(27 + i) & ctx->ret_addr;
    421                 hashed_bit ^= test_bit & hash_ctl_2M;
    422                 test_bit    = BIT_ULL(34 + i) & ctx->ret_addr;
    423                 hashed_bit ^= test_bit & hash_ctl_1G;
    424                 test_bit    = BIT_ULL(41 + i) & ctx->ret_addr;
    425                 hashed_bit ^= test_bit & hash_ctl_1T;
    426 
    427                 if (hashed_bit != intlv_bit)
    428                         ctx->ret_addr ^= BIT_ULL(base_bit);
    429         }
    430 
    431         return 0;
    432 }

regards,
dan carpenter

