Return-Path: <linux-edac+bounces-5158-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EE9BFD03A
	for <lists+linux-edac@lfdr.de>; Wed, 22 Oct 2025 18:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4E8A4ED21D
	for <lists+linux-edac@lfdr.de>; Wed, 22 Oct 2025 16:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD11026F47D;
	Wed, 22 Oct 2025 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0TaUEM0"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE4626D4C7
	for <linux-edac@vger.kernel.org>; Wed, 22 Oct 2025 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149084; cv=none; b=rlkxLz7kC6znMbM4ccE3/INjWY1m+t39KUfRuvxdUnqbmMWvqQeR5bs6AZ+5bWbxDkKTQ8miBNJ5Q/zquYu7G/jcMJrqRcrbXZ2jWrkgPKp21tlVWA6/365SKXTkut4qIlyQR/9ZUE850Z15a+Ra67qqZR9iON3f0psRgT+NUpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149084; c=relaxed/simple;
	bh=tc5vb/bSNQzNctsxf6Q1Tk4Lr10xsMh7rmFmEYOeH0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tvTzE7wh1hFAlQeCb0HaoIUcOEyVQZL3FaW9CELUGYx1ZUucSz0xFhi2JZnWPgGjP0NI8KVddtOM3KbZewJD+iVlXWuZUZ4p44znCEux2qkrGbNas+xQgwcoN+dwklXqXaaUDHl4PRQgeNTxqKHSWLYNZQ9EcvyWq6c+7P4Sl/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0TaUEM0; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7810289cd4bso6744413b3a.2
        for <linux-edac@vger.kernel.org>; Wed, 22 Oct 2025 09:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761149082; x=1761753882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=BZrD5LLpN6OKt5YsuuOVNE2JbK2nu1t0pORWzFY5nEs=;
        b=C0TaUEM0FWDDW7nRlh03gEp0cpENf9uu/DYQTEwSVGknT0+D/5Z750uLushLEGd+aP
         00hlnbTifSXusxFJbOxt8gXjnPMc4oOLT2bVoWP0WoFQxJw/Bw0Dut0e8N1LiDTf5rF5
         kWlvknyhZ1LnH3BbUloo9EwuA5TZeGUxffsePuI+9zgtTSS+YOTcexyEJLy4ILRgX6AP
         +MVl7zpE6LMgtCQikPgRb7wKBZWI3qg6DUzLjEhP8uiJpojdFoQ4prx6UOJKV3uZIXe3
         mfdO1ew8T/NoHiMR/2qgZ07j28qY3J13uWHIIjrQdLwr4LOftF2Vb/pqy6KSmCvu07qf
         Gj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761149082; x=1761753882;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZrD5LLpN6OKt5YsuuOVNE2JbK2nu1t0pORWzFY5nEs=;
        b=JFiHTZLcEuHL1VoOuQSeC4q4HfXK8VTdXqjLSm5X1+prr5UFXGiElcfKWQrLjFvKFR
         9GrcfY0MrPSukprQ0ma1Jc978+bq673PWj4IWYtxxxGl0n0x3XGtDFUlzwLouV8gmjC4
         jDwjrNh3yoUDrHEHPt8j9QNQtVt8jwtrPBklCDVC2RdDsHguovp5lnTZw6RvxacIa8ly
         FTjc2gVZ6FKtOStQO0DwlcbbHH5R/5kXR5WMf3Sg68+tw0p8pz1nCFLkhVNa2F8bcPij
         QwzHeFufO9VI7TB4sbee3U+7I9Sy2DLuDcgkrHMt4dEv/BHrczKzpzgCG0igqsUYPTot
         Jhgw==
X-Forwarded-Encrypted: i=1; AJvYcCWzA7g0UdYdDB8Fpz+UT9Ce3YpDDX4eRVd5kEZXVAbquXyVHdHHLOAztQqr1jeXKhgGyF6JHgFVXYUV@vger.kernel.org
X-Gm-Message-State: AOJu0YyUGz7PFmY46q8S+DMVtgB2MzKBrRf73fpRhXjdcry0syAZRHhZ
	L8OrNtvws0RZ6X0RPPeV/dm2tHxkBqMzHhzfV0lr+WXaUD3UW4VKi2wy
X-Gm-Gg: ASbGncvPLbeVYcYmU6vib8mbt2E7v4B3dZ/nQMGCECXtoOra2CNkuHP4bKgFgLa6LqS
	mOR8i95b6yJ9NLdMVywZH0eWqJ4kGssCql2BpvPqf+AnbcVojUBgYUYaYjMe7AN0T1jMS3hQFlp
	TlBtGoNH9Dm3WH6EzqWVwJl9EwMh/md8002e9OmOMdve8Hbckpkest2G+LOfyVzELr/HrUSTnTA
	BBUS/VR+R8bQkAQzXrlk+gIlAx4M9t1fXQ+S3qFbXuzl/bBEEzjNb/bBEl0JyzgEQTAyZBJEXYb
	H9Pocby6xye2dgH2HlaPhJt9laEJe9D8pnrR1KG58aMjLacjyxnzbvh4csZsoII7SS0iRg6791T
	fGwyr71jqGdmHEXCDqtSPfaShlajrXMndZDyZLl1CPwGYWnHBB8SXRuxdPDYZmSzUVr5GJCfPUl
	oTwWEFKgt4gVz6c6Mus8ojKmaAZ0CHgAv5DKjgeH9lXaL43VTsqe300oWvqYA=
X-Google-Smtp-Source: AGHT+IEQOgpotD6DFktZWc8LhLQ+xM+TQ4t1B4Ik3vjYJEf9wXyRwHjJKOLDXcea+TxECSng3wG7nA==
X-Received: by 2002:a05:6a00:9518:b0:776:228c:4ac0 with SMTP id d2e1a72fcca58-7a220a6a1ebmr24433722b3a.11.1761149082244;
        Wed, 22 Oct 2025 09:04:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23011084csm14955855b3a.58.2025.10.22.09.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 09:04:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2985b52b-baa7-42fb-9362-c1db02d171f7@roeck-us.net>
Date: Wed, 22 Oct 2025 09:04:39 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] x86/amd_nb: Use topology info to get AMD node
 count
To: Michal Pecio <michal.pecio@gmail.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Shyam-sundar.S-k@amd.com, bhelgaas@google.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
 linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 mario.limonciello@amd.com, naveenkrishna.chatradhi@amd.com,
 platform-driver-x86@vger.kernel.org, suma.hegde@amd.com,
 tony.luck@intel.com, x86@kernel.org
References: <20250107222847.3300430-7-yazen.ghannam@amd.com>
 <20251022011610.60d0ba6e.michal.pecio@gmail.com>
 <20251022133901.GB7243@yaz-khff2.amd.com>
 <20251022173831.671843f4.michal.pecio@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251022173831.671843f4.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/25 08:38, Michal Pecio wrote:
> On Wed, 22 Oct 2025 09:39:01 -0400, Yazen Ghannam wrote:
>> Can you please share the full output from dmesg and lspci?
>>
>> Also, can you please share the raw CPUID output (cpuid -r)?
> 
> Not sure which "cpuid" software you mean?
> 

This ?

$ cpuid
Command 'cpuid' not found, but can be installed with:
sudo apt install cpuid

Guenter


