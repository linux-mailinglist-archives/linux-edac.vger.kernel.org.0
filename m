Return-Path: <linux-edac+bounces-2464-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1905C9BF86D
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2024 22:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F382840A0
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2024 21:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D53F1D90B6;
	Wed,  6 Nov 2024 21:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b="ItebCpsV"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2E21D63F8
	for <linux-edac@vger.kernel.org>; Wed,  6 Nov 2024 21:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730928197; cv=none; b=LJw0tlX3o7HT/NUoyqrf4zzNUJdcR2RnY+QKjfEEEwTCgNc4C6aJqKgds13lNK9e6piloj6EHcPAzbhauakRx3IBaKga1Lvc0a5yt+lCtvtcNrUb2DlKy1cOZ4DWV0MgYQB7UbCOVOP7mLSBJys6UXWeBRaRLcFVZAdK7P1AjSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730928197; c=relaxed/simple;
	bh=U2i4d0ltICF/+70KkScTf5AWsmvfByR9kQmrJbRsOcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AFlqsIjFYcbdqs5eHrhkGclnV+mKZrr6FknsUqPuMTrjwQTXVgUKa6IFN4NRcAnIbplN8a2sKHmQYQszUlc8PrL86iEGyzmCOHnMxPaquLaT5GmIpZh6xi2wOuqpOVhLbh+/NtaUqzfW7Ka9slClTuYtqGZ/bltB6GWxwxISHfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io; spf=pass smtp.mailfrom=aiven.io; dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b=ItebCpsV; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aiven.io
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d43a9bc03so137047f8f.2
        for <linux-edac@vger.kernel.org>; Wed, 06 Nov 2024 13:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aiven.io; s=google; t=1730928194; x=1731532994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xmvNN6gesL90wm4yphATi3h7Pns2kBBZ4GSb280H7Oo=;
        b=ItebCpsVCJMFBUG+It6d0ouVyg85a8VWKMOtj6BLWJMA0MOTJ5AMAHWoOLZngcGeoF
         nImLg8FJ5N5lrNN2Mnq8eOI6jTonFy5TGFh+mb6lgjSLstp3XMJKDicvrOLc83gkx0+/
         e3eJjRTk56kUktttcT+iJ2ak4VZFZtnv4qUkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730928194; x=1731532994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xmvNN6gesL90wm4yphATi3h7Pns2kBBZ4GSb280H7Oo=;
        b=RjxiOL1L/4dGEc7Sz8xiKzz4SoH6LOP03w+AhY5y/sjGWLSB+IKF28wlPmGW/fkbod
         IqSCE2AohqJ7bRKPtcofhAxKxUTRYIUPqGaKzJRWpgDzUYs8bhTk6d+Lp/BYuRFdYZDr
         61yM9jTtbrRtluei07PReGZyHTmyfLwyRwR8PkVHe34+XYOY4OaRbGWQsQ16Dspn8roy
         X567Z9GDOU3ijgsEMKzI1aNpT6ZOPBRHd18BM1XSTuEZW9hbtAjqDMGOYCPZYT0ryiwp
         3WITDp+pGb3GF64zxMYgceyCJgO1jY+jGggqUZRGTcgpq9V526nFTuf42Qku9GYB3Fj+
         fnpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcx2LJmrdQvseTdPvYz0l2pEbJz44NFvE6EzNbW/a+9/U7uUNRNiWjpQ1RE3eckOxGJnG70NKhd3oc@vger.kernel.org
X-Gm-Message-State: AOJu0YwqnysXn6rXqlKFzSS2kusNDodK14/7P5SG7FUKr7ZrjUbET/Mo
	L46dO6XfVwBl6tkbWdZ2F1FhLHi+7s8ujydHDDWNrNFHldLKjx7aZs687j1NeFU=
X-Google-Smtp-Source: AGHT+IFOH1fZS7r2xCtxhzRmFDfp0bLlLooQZDFMXKH6gRzno8hFIF3XfaxktR5N9V1g12TGoQiL9Q==
X-Received: by 2002:a05:6000:1f8c:b0:374:ba23:4b3f with SMTP id ffacd0b85a97d-381c7a484e7mr19608917f8f.9.1730928194104;
        Wed, 06 Nov 2024 13:23:14 -0800 (PST)
Received: from [10.0.8.225] (n114-74-229-70.bla3.nsw.optusnet.com.au. [114.74.229.70])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee7688e38dsm7377127a12.22.2024.11.06.13.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 13:23:13 -0800 (PST)
Message-ID: <9c7b9fad-408d-4767-9aeb-4e2333b0ece9@aiven.io>
Date: Wed, 6 Nov 2024 21:23:07 +0000
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] EDAC/igen6: Allow setting edac_op_state
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, "Luck, Tony" <tony.luck@intel.com>
Cc: "bp@alien8.de" <bp@alien8.de>, "james.morse@arm.com"
 <james.morse@arm.com>, "orange@kaosy.org" <orange@kaosy.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mchehab@kernel.org" <mchehab@kernel.org>, "rric@kernel.org"
 <rric@kernel.org>
References: <20241106114024.941659-1-orange@aiven.io>
 <20241106114024.941659-4-orange@aiven.io>
 <CY8PR11MB7134C2A2328E5B8B3285C81489532@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Language: en-AU
From: Orange Kao <orange@aiven.io>
In-Reply-To: <CY8PR11MB7134C2A2328E5B8B3285C81489532@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/11/24 13:04, Zhuo, Qiuxu wrote:
>> From: Orange Kao <orange@aiven.io>
>> [...]
>> Subject: [PATCH 3/3] EDAC/igen6: Allow setting edac_op_state
>>
>> Current implementation does not allow users to set edac_op_state. As a
>> result, if a user needs to test different edac_op_state, they need to compile
>> the kernel.
>>
>> This commit accepts module parameter edac_op_state which makes it easier
>> for users to test IBECC on their hardware.
> 
> An SoC's (with the IBECC feature) memory error reporting type is determined.
> Switching from NMI to Machine Check or vice versa for a given SoC is pointless
> in the real world.
> 
> Additionally, the interrupt mode is preferred over the polling mode unless
> the interrupt cannot work, as in the case you reported.
> 
> [ Sometimes, no choice is the best choice :-). ]
> 
> -Qiuxu

Thank you Qiuxu and Boris. Good to know. I don't have any "actual" use 
case so please exclude patch 3.

Thanks

