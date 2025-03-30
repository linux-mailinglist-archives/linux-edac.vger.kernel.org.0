Return-Path: <linux-edac+bounces-3415-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCB2A758E3
	for <lists+linux-edac@lfdr.de>; Sun, 30 Mar 2025 10:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5DC18889CC
	for <lists+linux-edac@lfdr.de>; Sun, 30 Mar 2025 08:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE32F9CB;
	Sun, 30 Mar 2025 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natrix.lt header.i=@natrix.lt header.b="wZAJFtv5"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EE81876
	for <linux-edac@vger.kernel.org>; Sun, 30 Mar 2025 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743323126; cv=none; b=OmyosPBq0uM2gxSVk4AkroVx8p/UUr0laX8cSa1W5JhCFLn5KY4nYJMcakGZCseCXMYFWsXxnBKVhfH7o39LBBFuTPmtCaiEKv2LgqLqPS6Yn9mjKcl2xm1gc46/rDDPXpV6N8V2x9ad+Li4g/CDuexhkbPWsMxSXOXLUg3jFk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743323126; c=relaxed/simple;
	bh=rr8bSJpysdOlPnCzHucsgFnZre1aw5MwhzQn01AvRwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BEQAzLCfN5GdIq7tt3gQXk8Q6LNDYB7DStIs6PaCGA0oklPDuo0bJjjW54BQLBYjMHhFwMoTIXv5JMTFT92L28ic1r2+Ha2fCjLZhFtQw7XcjPbxhBL/dkV1UwyRCfImX/Bxto2+YkiHU8FXUnTu+PwWYbH+Vd/PJb+1Uhyi2lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=natrix.lt; spf=pass smtp.mailfrom=natrix.lt; dkim=pass (1024-bit key) header.d=natrix.lt header.i=@natrix.lt header.b=wZAJFtv5; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=natrix.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natrix.lt
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e60cfef9cfso5516132a12.2
        for <linux-edac@vger.kernel.org>; Sun, 30 Mar 2025 01:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=natrix.lt; s=natrix.lt; t=1743323121; x=1743927921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hPMUMfo/GFfwzCn777MFn58blW7lyD5RKxWeVqiLxbE=;
        b=wZAJFtv5BR9bU69Xx+9YW49qk1MXrF+aoB87GM5cieKf7OdoRxuHSYqEejaCoFWNra
         ZkdJGHOTq561v6mbPHxBscHEMe8Pk9OOLyC4awfX9Id4L+Q8ZzhJ/GCVqFwusw7EGEdy
         +I313wBQarPSHNwnfGjaPzNbDAwKG8E7oq62U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743323121; x=1743927921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hPMUMfo/GFfwzCn777MFn58blW7lyD5RKxWeVqiLxbE=;
        b=tmIuhvIKVyzn7jFlb+FSCBFldRdWRktmJ76W9AaymrB9ij0Rk8uxvwJV/ZbJElIZ+7
         IYXiZTkYJmHQUavZDSFfu4JWSd3rj1G2E2zjItZJtCEVd5PQIjSy2hC8/PqBr5VwWRnv
         Kp1JzSQQnxKg6HwGVfqCK4FnCEm7OGio1AsNyz4Giyeg0ql3ba/Gou6zsAsB09YMPIxt
         5e6c0/GqpZ0qQ7JOtBlzm26FvBt5X+PFKfBSclysQrS75bTXHr4vaLyXIY7XpmpfsLvM
         nb8wJGjGv2/FBlt1atNniLXK4VWs450OtuU9A8t/vmxJNxroqmziPDzYcOFwny1lqFsb
         5zgw==
X-Forwarded-Encrypted: i=1; AJvYcCXzrOXlVPa4yxdiw+YrIuiF+gCVbHKMjpG8urfDS9r2m3ZKdMh65wglf7yc0GqhvwO0LTe/00CaoxF9@vger.kernel.org
X-Gm-Message-State: AOJu0YxEwDPfdzngT+wQRVda9dKo/5IOx7R/QqUk4b0VTUgj3ncjfNCm
	ZPgXGMV+hYLK4+5qnIh/qZllIGaSpvG3oPj1cwSKZ0PoxDWsjuHBV0CDQ5/SXGI=
X-Gm-Gg: ASbGncuLnzqzH+fTENJ7HOVgTM3q28WC1mKdQzgT49m+RPVPPbuzgMZ1w1jjBLJ6ol2
	/avepGRnBdM7VNTCt06FS+0UAb8tj/M03A1GhnjRgD9PD0HAm5jdR32trfRPNI1Qcoo0TCOYVU0
	yPjcYCLvCxZfCsvTfTD3UVLe1rEp0llpNJlsL/S4uhkVKlhW1yfwPOz8h1OMzBl97DpYLXwjfcD
	EHdW0vEni1mqkMqcDQoYPQlyiTN5+G/xYo31+xFqzeF9qZcjWbCESTX9fCe2QVrN02+Tnv2pS2p
	NJb3PcYIQm3GkvNu/pSYgYJSXxEigCP5zQ565ve63U0JkUjWgyKWiepY7PYvTg==
X-Google-Smtp-Source: AGHT+IHWJhfhLTFnK7L6lBr0OaKVEaKpSnYvzmVqdDb1uzQzrHL0HE/nuc0jMZ45R8FsaRbQu9z87w==
X-Received: by 2002:a05:6402:3554:b0:5ec:8ef1:35c4 with SMTP id 4fb4d7f45d1cf-5edfce76a78mr4594269a12.13.1743323120694;
        Sun, 30 Mar 2025 01:25:20 -0700 (PDT)
Received: from [10.1.21.7] (beta.natrix.lt. [212.52.62.69])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16d3629sm4005575a12.23.2025.03.30.01.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Mar 2025 01:25:18 -0700 (PDT)
Message-ID: <e1b214f4-1093-4713-9ba6-3a9774ed4d63@natrix.lt>
Date: Sun, 30 Mar 2025 11:25:17 +0300
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Memory controller not showing half of the memory?
To: Borislav Petkov <bp@alien8.de>, mailinglist@reox.at
Cc: yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
 Avadhut Naik <avadhut.naik@amd.com>
References: <20250317120702.GA7066@yaz-khff2.amd.com>
 <dbec22b6-00f2-498b-b70d-ab6f8a5ec87e@natrix.lt>
 <20250328152415.GCZ-a_HzI0zpcaLNWD@fat_crate.local>
Content-Language: en-US
From: =?UTF-8?B?xb1pbHZpbmFz?= <zilvinas@natrix.lt>
In-Reply-To: <20250328152415.GCZ-a_HzI0zpcaLNWD@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-03-28 17:24, Borislav Petkov wrote:
> Both of y'all folks encountering this issue, care to run the below patch?
> 
> https://lore.kernel.org/all/20250327210718.1640762-1-avadhut.naik@amd.com/
> 
> Thx.
> 

I have applied that patch on top of 6.13.8 and now EDAC shows:

UMC0: MC0=0GB, MC1=0GB, MC2=24GB, MC3=24GB
UMC1: MC0=0GB, MC1=0GB, MC2=24GB, MC3=24GB

it looks correct now.


