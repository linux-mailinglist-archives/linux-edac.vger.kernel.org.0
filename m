Return-Path: <linux-edac+bounces-3981-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED6CABFB3B
	for <lists+linux-edac@lfdr.de>; Wed, 21 May 2025 18:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33A827AEB5A
	for <lists+linux-edac@lfdr.de>; Wed, 21 May 2025 16:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E341E1DE8;
	Wed, 21 May 2025 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIJVQZZ3"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1840E16DC28;
	Wed, 21 May 2025 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747844915; cv=none; b=pFfR4SkCa1an2j5oHp3l91ITPHteHc2X4FpIYa7rGI78rDfabLqrOc9NkcHGTrdcodhP9KbpjMyyJH90R2pEu8dghuQ1cywoigJKcrxYnLgES16m2amTlNBxp+Pws9Wdtk3KNP0T9AjLGpA7cytUtLCnBWh8AoDmgOyKrpuYXgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747844915; c=relaxed/simple;
	bh=rbiew2xFDSn1FN1RhaLn3Hgr55Spum0T/3YxvWv+4y4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GO2Z5wygK/qcXV/1OwwlSxSDLQsDgVZYGOV3AnNGPvFiQ1tBLyK97kL0PkGzIqI+y72VBRH2wIU9ockwGy46z0lpVrqchScgRT9tFLPCHtkz15YCUOPLe6vUwgRpnz80sHmkyRNg4CgCgSH8SQqhnKtmfuqu528ZY0mTxGbT1x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIJVQZZ3; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3108d54332eso807602a91.2;
        Wed, 21 May 2025 09:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747844912; x=1748449712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pIggStz/RXQy+Pzj/PgUplHF/0nY494c0KtJ+rdPSo4=;
        b=EIJVQZZ3zB3RLeJXGYjdg75CSC1YwKH8DYIWxCfOpQi01wIwy5km/a5gOmMu9WHKSN
         FBGwtClkEbxVy3mX47lLVnXwENF/gRPi7iZlbahApmrQMYf70/ee5tV8hoNygCdEb88r
         e6hwWpr+Q5pBgsgEMWfxPLC7OlZ1M/xjjDubLlhoHFNtKSIhFpfk8XmHtNT3JGfBRDea
         u8V9XuOKC2f0oUUYFhiKz61h9+21339G0IXMYTSelkENOUiKETg1om0rHhjkysm+816s
         9nldEc2Q2t6THtQ0OyV5JoYTDx3TjTDmLKxRWvx3uUgwg3h2FXfWqfNQev4E5XQUoors
         q6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747844912; x=1748449712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIggStz/RXQy+Pzj/PgUplHF/0nY494c0KtJ+rdPSo4=;
        b=FQ64H/2mWmK/ark9CLVG0kj238WmhXwukl+DxO9LJh0yT0u4DAxTdXnVrQuWk1+652
         HpqQRdR90I9BRdW+D15bSSc8tvA61PfTdzSEILsEpvMeeM6a7N1E0oiPsK14lTDGWyWp
         u1v+ishHGWh+Y6G/SRO0IxlDn6QFp3L9Id806RHHHRVL+/OtdKr2Mke5tz9PVeBIOrUv
         eDQgHt/dx8aCXHqZ+1FkUUEVek9DrQZ0ac4jxT4BezkDGXSLYSnNRSJKR9zueBPYdNsa
         EAZW0qOHj9MWT+Koo/H715wzxmqkIyqiv2WgjncbKCuOUolVhcqR4RdF4d6Xm7ZtfQ3c
         3gfg==
X-Forwarded-Encrypted: i=1; AJvYcCViqouLUeGd3wclT0DB5haFK5pKoJ8CAWTQkWLjNxUqbs1fSTMrepSejbC2OyZhN5vFga6/LL1J7gnPyQ==@vger.kernel.org, AJvYcCXXsj3s934AyoHyierVql+GkrWZUgXlQusx+2IexGFokswCKyTyAafs8tRf55kpLEMbgbsTfsjERAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywog41ZfDvn+5qMDA86YKXYXG8zk9S5dBLLz8Zs2VcYCwkYauiN
	9TREp0+V815sx5rI+VZfqZKAJKj2hqlLDaKK2V/Ic1FbDrMRl6yNhlIs
X-Gm-Gg: ASbGncsaFgxAcKWDEGdccWOjB5dmGyoZBGMGTiNAtJnF6mgZCgE2KgCCj52qQMq8cp9
	gAQx7gXBhnObpXK8JRyhuXUHgRcj2AsGYNKoxbHPQ1wvPl3QIUpFKfjtxvVaPwg4INUOcknQKJH
	fbObPGgt/4ZlckC5ct+2p2uvBbzxPXKQShxx2++k9adwdeMpip7oCGuH16XFt0JzQuau+8WqBsR
	6fG9heaQpiUPEMEtcgRObRiUDgqOKZXxWzg+3jImD6EIQnsf4PcQwb7uZ6fUGB+4Di9sohV7igz
	WkCc9oK4KrTnNxKCrcXPDTbnL+eRdv2Wvy6Av1p13Oe5xgUoo3+aLQQYFMERC8Gb/w==
X-Google-Smtp-Source: AGHT+IEFj9doKcpfTPVJWe7aov/vMTA7xf4yNgqObIP6ArrfA7NGdJu4q7Ixx3DqhByW7G/78OnyHw==
X-Received: by 2002:a17:90b:1a91:b0:2ee:e113:815d with SMTP id 98e67ed59e1d1-30e830ebc99mr31724033a91.8.1747844912125;
        Wed, 21 May 2025 09:28:32 -0700 (PDT)
Received: from smc-140338-bm01 ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365b2da7sm3860928a91.9.2025.05.21.09.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 09:28:31 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Wed, 21 May 2025 16:28:28 +0000
To: shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	dave@stgolabs.net, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	linux-edac@vger.kernel.org, linux-doc@vger.kernel.org, bp@alien8.de,
	tony.luck@intel.com, lenb@kernel.org, Yazen.Ghannam@amd.com,
	mchehab@kernel.org, nifan.cxl@gmail.com, linuxarm@huawei.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com
Subject: Re: [PATCH v6 1/8] EDAC: Update documentation for the CXL memory
 patrol scrub control feature
Message-ID: <aC3_LDduxFk_V_AP@smc-140338-bm01>
References: <20250521124749.817-1-shiju.jose@huawei.com>
 <20250521124749.817-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521124749.817-2-shiju.jose@huawei.com>

On Wed, May 21, 2025 at 01:47:39PM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Update the Documentation/edac/scrub.rst to include use cases and
> policies for CXL memory device-based, CXL region-based patrol scrub
> control and CXL Error Check Scrub (ECS).
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  Documentation/edac/scrub.rst | 76 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/Documentation/edac/scrub.rst b/Documentation/edac/scrub.rst
> index daab929cdba1..2cfa74fa1ffd 100644
> --- a/Documentation/edac/scrub.rst
> +++ b/Documentation/edac/scrub.rst
> @@ -264,3 +264,79 @@ Sysfs files are documented in
>  `Documentation/ABI/testing/sysfs-edac-scrub`
>  
>  `Documentation/ABI/testing/sysfs-edac-ecs`
> +
> +Examples
> +--------
> +
> +The usage takes the form shown in these examples:
> +
> +1. CXL memory Patrol Scrub
> +
> +The following are the use cases identified why we might increase the scrub rate.
> +
> +- Scrubbing is needed at device granularity because a device is showing
> +  unexpectedly high errors.
> +
> +- Scrubbing may apply to memory that isn't online at all yet. Likely this
> +  is a system wide default setting on boot.
> +
> +- Scrubbing at a higher rate because the monitor software has determined that
> +  more reliability is necessary for a particular data set. This is called
> +  Differentiated Reliability.
> +
> +1.1. Device based scrubbing
> +
> +CXL memory is exposed to memory management subsystem and ultimately userspace
> +via CXL devices. Device-based scrubbing is used for the first use case
> +described in "Section 1 CXL Memory Patrol Scrub".
> +
> +When combining control via the device interfaces and region interfaces,
> +"see Section 1.2 Region based scrubbing".
> +
> +Sysfs files for scrubbing are documented in
> +`Documentation/ABI/testing/sysfs-edac-scrub`
> +
> +1.2. Region based scrubbing
> +
> +CXL memory is exposed to memory management subsystem and ultimately userspace
> +via CXL regions. CXL Regions represent mapped memory capacity in system
> +physical address space. These can incorporate one or more parts of multiple CXL
> +memory devices with traffic interleaved across them. The user may want to control
> +the scrub rate via this more abstract region instead of having to figure out the
> +constituent devices and program them separately. The scrub rate for each device
> +covers the whole device. Thus if multiple regions use parts of that device then
> +requests for scrubbing of other regions may result in a higher scrub rate than
> +requested for this specific region.
> +
> +Region-based scrubbing is used for the third use case described in
> +"Section 1 CXL Memory Patrol Scrub".
> +
> +Userspace must follow below set of rules on how to set the scrub rates for any
> +mixture of requirements.
> +
> +1. Taking each region in turn from lowest desired scrub rate to highest and set
> +   their scrub rates. Later regions may override the scrub rate on individual
> +   devices (and hence potentially whole regions).
> +
> +2. Take each device for which enhanced scrubbing is required (higher rate) and
> +   set those scrub rates. This will override the scrub rates of individual devices,
> +   setting them to the maximum rate required for any of the regions they help back,
> +   unless a specific rate is already defined.
> +
> +Sysfs files for scrubbing are documented in
> +`Documentation/ABI/testing/sysfs-edac-scrub`
> +
> +2. CXL memory Error Check Scrub (ECS)
> +
> +The Error Check Scrub (ECS) feature enables a memory device to perform error
> +checking and correction (ECC) and count single-bit errors. The associated
> +memory controller sets the ECS mode with a trigger sent to the memory
> +device. CXL ECS control allows the host, thus the userspace, to change the
> +attributes for error count mode, threshold number of errors per segment
> +(indicating how many segments have at least that number of errors) for
> +reporting errors, and reset the ECS counter. Thus the responsibility for
> +initiating Error Check Scrub on a memory device may lie with the memory
> +controller or platform when unexpectedly high error rates are detected.
> +
> +Sysfs files for scrubbing are documented in
> +`Documentation/ABI/testing/sysfs-edac-ecs`
> -- 
> 2.43.0
> 

-- 
Fan Ni (From gmail)

