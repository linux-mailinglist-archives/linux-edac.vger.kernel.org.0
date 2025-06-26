Return-Path: <linux-edac+bounces-4258-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E2CAE9771
	for <lists+linux-edac@lfdr.de>; Thu, 26 Jun 2025 10:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2F517EF0D
	for <lists+linux-edac@lfdr.de>; Thu, 26 Jun 2025 08:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D6A25BEF6;
	Thu, 26 Jun 2025 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UMY0CRr3"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E32825A34F
	for <linux-edac@vger.kernel.org>; Thu, 26 Jun 2025 08:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750925006; cv=none; b=PGJ9sTDITOkOlkhngfJPG6djmwr2GmoGeoCJFJtJwwgTYOYWHoSHtH7bGM2l54gAovoPeFpRGYhG9n5kXKoQzTxGc+hHYOC3BBtfLXp/dSq7VnG2NgTUZuvo9JK9JEMwabpzmxpRqBDgIotHSavXN9dHaVMHvdbH1o3AKli5mZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750925006; c=relaxed/simple;
	bh=TX6cbqK3A7wm0xr8OkuHjx5m5oXahXwOVit8R3fCsJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SBjjrxPT22wGgxueksabaYtvkXj0ABijB03w75BvPS7gDRLh6qIaQ64UbN+h700lzM5Wuz8EF3pyjqQyxd4DFShp8gynmtIZj06jBoaGxeArNQ/molyeVW8OkiVoKoViDOWe1uwtNRPGDNA+0zIqr6CWbMXityjw8sUPK+UYH/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UMY0CRr3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45348bff79fso6583655e9.2
        for <linux-edac@vger.kernel.org>; Thu, 26 Jun 2025 01:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750925002; x=1751529802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eASQdGU0xGhBkNS6Re9mJOkMCP/ZJe7Z9f/s6yhHpfI=;
        b=UMY0CRr3MK6r+JkzVFNGb4ePcbdW52arXsHEFsA/6oieqDhxRNxw0tVMGHTIY60nAE
         W0ZZ2LY6bfH69r+YXXOwAgOpbyHBw1xx06pRpbJfpvTI8EZDYUpVzUNZPzb+Avhd7MOk
         MQ2n0qIDA1cIvgju+MnzGmru6Q6Dg1Z+wqBOn2uH4EW6tzm87+SqJJfJL+FYkMqHrfuS
         Be0++E7A3Ig0+QycyEDw+rIeGG06RrDMmYzJlGbUwAjWhTf+Q5qWGBF8LYz3BmtN5iCo
         Q3NgphZxvTEoWogLLLHYOn2H8g2ekKRHsZTslTVOWVHgqJ0hPmU7uflS2WNOpiV3Z8pf
         cIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750925002; x=1751529802;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eASQdGU0xGhBkNS6Re9mJOkMCP/ZJe7Z9f/s6yhHpfI=;
        b=VNdRAIZhPPr2u7ogJ6A9S9ykcjjalS3gv/o4UpqPQEu9cOqsAigi86ncF/OcGm9frF
         lyV4VUSC91kLBPYmXdVs3uu+G9A9DHAtLRLGIb/r0Q/1Qw/URNbveQqRBR2gXNo/SRnP
         fm/s26x0+ZwruQJDwcFBIo+TUMgiBaA2n6o8cQttc725hFC/1gt5ldUEmZiipzz2OWd6
         2B6WB6ZBNm2xe+KyHkztOqH9a3rkHeOlHkjYdzWmOORuFdIb0FybuSOixMCwWdvonnxS
         bfFEdPii3JVOi4lPbsAZK/yQY0wkiEkofdhT2hIVitebXkjz/RtdYFicYX/7mPZwWCSj
         eAMg==
X-Forwarded-Encrypted: i=1; AJvYcCW6xYIJwqidThCondqgiHIyQouz59kPMIcp4qpRoIXpSQwY7jxhM7QzUzb4HwwURBElAveRlNcA/Lud@vger.kernel.org
X-Gm-Message-State: AOJu0YzCtQF5tYqG0CFZOz+sGsBUA1p9U+1sTnW8CIY2ml+6/b8PAuls
	+rDSzwZqGkwH5bFTLNlG86G+PHG5oZfzu5Vpgag9O44Jw4mLCFzIKDCUtaN/5F+gsNA=
X-Gm-Gg: ASbGncupS6PDAZ4hi9esI7fR3GHqtbl4E5vrjxxD++ONMxobxcFv2gPpGB6q7N3Co4f
	4YC8qwpgAw6AdQ4sOyRSuEWyyWGGBhVxV+rcGDbQKMsapB1Cmx8OHMiYlJgVIaZm+zn86xk0SAe
	sC/KMsj7q4prWsUXZYbo1Xqm7eVC4joZO28lLFXlzycrNyfygDeDX3wApumX3An/4I6JZap7TVg
	cFOAqWnZCMXrbrZgEwWelJb02vt9MfKSzVVQFIJ96YVixXZRY9SVwmtQTE4mauuAL1ARMKx4DXu
	QKzt4O7vafIdqrvPlOeGjvkz/BqIwdOmFZ1VN8UbFgp+PNhhXr9PWpRIvm26K0NIO8AYX/an3bb
	e
X-Google-Smtp-Source: AGHT+IF6yQImeJzcD3ZrKiWueyJc8jgxSQIaNzReiWnJay/LPDvnwG+t/EWe4mdsd+HllkB5N/cBWg==
X-Received: by 2002:a05:6000:2dc2:b0:3a5:2e59:833a with SMTP id ffacd0b85a97d-3a6ed5d62f2mr4861840f8f.1.1750925001683;
        Thu, 26 Jun 2025 01:03:21 -0700 (PDT)
Received: from [192.168.0.20] ([212.21.159.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80f27besm6691313f8f.57.2025.06.26.01.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 01:03:21 -0700 (PDT)
Message-ID: <52a37afe-c41b-4f20-bbdc-bddc3ae26260@suse.com>
Date: Thu, 26 Jun 2025 11:03:20 +0300
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/22] x86/mce: Remove __mcheck_cpu_init_early()
To: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 linux-acpi@vger.kernel.org
References: <20250624-wip-mca-updates-v4-0-236dd74f645f@amd.com>
 <20250624-wip-mca-updates-v4-10-236dd74f645f@amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20250624-wip-mca-updates-v4-10-236dd74f645f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/24/25 17:16, Yazen Ghannam wrote:
> The __mcheck_cpu_init_early() function was introduced so that some
> vendor-specific features are detected before the first MCA polling event
> done in __mcheck_cpu_init_generic().
> 
> Currently, __mcheck_cpu_init_early() is only used on AMD-based systems and
> additional code will be needed to support various system configurations.
> 
> However, the current and future vendor-specific code should be done during
> vendor init. This keeps all the vendor code in a common location and
> simplifies the generic init flow.
> 
> Move all the __mcheck_cpu_init_early() code into mce_amd_feature_init().
> 
> Also, move __mcheck_cpu_init_generic() after
> __mcheck_cpu_init_prepare_banks() so that MCA is enabled after the first
> MCA polling event.
> 
> Additionally, this brings the MCA init flow closer to what is described
> in the x86 docs.
> 
> The AMD PPRs say
>    "The operating system must initialize the MCA_CONFIG registers prior to
>    initialization of the MCA_CTL registers.
> 
>    The MCA_CTL registers must be initialized prior to enabling the error
>    reporting banks in MCG_CTL".
> 
> However, the Intel SDM "Machine-Check Initialization Pseudocode" says
> MCG_CTL first then MCi_CTL.
> 
> But both agree that CR4.MCE should be set last.
> 
> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Tested-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>


IMO the change which moves __mcheck_cpu_init_generic should be in a 
separate patch so that in the changelog it's abundantly clear that it's 
a "world switch" function and its invocation timing is important.

<snip>


In any case:

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

