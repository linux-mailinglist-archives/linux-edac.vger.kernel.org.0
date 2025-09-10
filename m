Return-Path: <linux-edac+bounces-4774-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C30B517DF
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 15:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E56461BF1
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 13:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A342D0C7E;
	Wed, 10 Sep 2025 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ApCtoVsc"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5851F03F3
	for <linux-edac@vger.kernel.org>; Wed, 10 Sep 2025 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757510832; cv=none; b=mdRMX6+Y9jy1/2iMETcIUU8UH8tCdkD4VgfdL/tnkt07Mer3qhXdShpqeXF4Hkyw9m6P4YrxhDmL00N1XgmqzRWSbP5EWgN8v5udDWhpzNJ+FtFT9GVciBcEoMQLgs/RNuX2w3FjeKCgWVq8zTDEAvvCI4uveCpyVNFfMv+mOsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757510832; c=relaxed/simple;
	bh=ogVm8trucvDSm3Kwtl2iXjtv1SvKNGL9WqRdEd8fHcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q5Vd70PcH1JwczlE4DM4/BbsAgop0hjCwy9aT6YY4/DPAKrcDRB6Mt4F4j2U0SjR+hmSg1G0setSHJAERxm4vHe3/0fnyKYjdZH/OcAjqddxgyz08wIn8Q7fP8EgyR3hYCiT/NNr958Xvd5UM3JEyC7p6wvWiEz7tnj+JeD6efM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ApCtoVsc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45df09c7128so6249795e9.1
        for <linux-edac@vger.kernel.org>; Wed, 10 Sep 2025 06:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757510827; x=1758115627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u0KH36ZKXhdeAdnK3QlMzkwzGwV1sdl29nhq++hRLN4=;
        b=ApCtoVscftwGEYSefc9P7/f3xhc4SW366qqjReRdGJKxKGHRaLaPhKYuus9jA8pxFn
         X1aFIsxPzgDg7fGZLwMOLuH3tRbs29bRhfURH2eeUoq/MBW73UHEFq+7fZ3ZJ/Otj9G5
         tnPtwqCA33t6TfpOD3V7yYpvK/IR6sBk5hpR4SKpRfu+H65vd3zRAMvYzae137M/Dxlc
         8X+ehXU4zPB4cXRmB6MiXqPYqNdbtLXGtn8yklOQcXEFlp9NfVjqoy8SpveMK3Ez2fPC
         IWDUge1nt1I6IEKW79hYFPypLkLihjT3L3ilnYw30KgPAsgM+Ye8wQIc2hVk42j2zXQ1
         kbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757510827; x=1758115627;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u0KH36ZKXhdeAdnK3QlMzkwzGwV1sdl29nhq++hRLN4=;
        b=BiIY/KOHyHwGY2nOII3XeqDDPXfJ4ceW+JF+c44vPqhhKlx4a01imREPah3UtABACe
         yf4PG6oIEhZp4o+O6w4Z2mevrLagdWrgoVvduhFlLpdaoHM+GZC5uPavFFX7RosaoxWn
         dl58pcwcaT/NmUUqBYv1lSRwEWgKR7sH03ZxA7f2pPDKePC53jpnBDeN2zKBlVRMj+sB
         L+/cxGeZlEwhDNunZz0mB9Sa/0BvggXPEDphqJfKWF3HKNvBUTV55gfmsNc8lDhl4r7H
         csy1RVCTllUaElW4f2bjh2GgYQWzAy4cYvI3RnnQDnB6bckb8xazcfZkWRuLVjcD6nL4
         xBlw==
X-Forwarded-Encrypted: i=1; AJvYcCV12uygAK5Lu+g1rofYkK7SWMTPSW537aAMQ4dqlH86N480H8q1/st3PVIkjGDosLrsvq83YJv2LuAh@vger.kernel.org
X-Gm-Message-State: AOJu0YwGOkzY/gufxBYGIJMivMMhA3XRs8/B72fs79pqchWgvHm9V1hK
	qDXTqxBrMfnEUcewZN2NMtEXbARrEZPLpB7DO7Vh3z9FXnXg7Rdzu+27lZmvgdZOTLc=
X-Gm-Gg: ASbGncuithJnzepCFRtPoGbeAsFTqLtWxtrlih21JJ+LCMy7Jf5JozzbZfra84pEpTQ
	zXztbCxO3ydq74n1IRiBUnysswZxdU2Mc5nacoY/I/8Aj/pr4CfrY8sLLW826URPHA9Ox4ZjL4x
	6+GkaPEib3sCkqD6SH5HpSs9loFEMJTJdNWMA3mUOSGL9FGS3X8jYNcKeEpu+cWtxH7dQKLfnlx
	cNU1IQGI2NGQCZf/59RtA56rFqQG67VFmOVstWgFyC5Mf0CTh1fa14A5U7QXWcN4N8A1vI0RV97
	21GyTuaO/FvDZhOkbFbDtyCb5MZm9fp+nZbGqg9AfSx7t5jWBfghsMPUkh0OZArNL9kvUjBg2IH
	NpH1+D3VSMbhIwGf8L713XNvNRut5c5n5EaOKv/d+TbsXmA==
X-Google-Smtp-Source: AGHT+IETw7dFN/bGOQqvrqcqGTQ0XCg0cHB9VY99Nl5WYPWvawcJVIy7xgIbI3+xfTA4oikqjgmGYw==
X-Received: by 2002:a05:600c:840f:b0:45d:dc10:a5ee with SMTP id 5b1f17b1804b1-45dde20ee09mr143413245e9.15.1757510827160;
        Wed, 10 Sep 2025 06:27:07 -0700 (PDT)
Received: from [10.20.0.214] (ivokam.ddns.nbis.net. [109.121.139.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df820d686sm27843075e9.10.2025.09.10.06.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 06:27:06 -0700 (PDT)
Message-ID: <ed56eac5-2484-4ac8-947a-5ccec80fa298@suse.com>
Date: Wed, 10 Sep 2025 16:27:00 +0300
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/15] x86/mce: Do 'UNKNOWN' vendor check early
To: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 linux-acpi@vger.kernel.org
References: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
 <20250908-wip-mca-updates-v6-4-eef5d6c74b9c@amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20250908-wip-mca-updates-v6-4-eef5d6c74b9c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8.09.25 г. 18:40 ч., Yazen Ghannam wrote:
> The 'UNKNOWN' vendor check is handled as a quirk that is run on each
> online CPU. However, all CPUs are expected to have the same vendor.
> 
> Move the 'UNKNOWN' vendor check to the BSP-only init so it is done early
> and once. Remove the unnecessary return value from the quirks check.
> 
> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Tested-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>


Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

