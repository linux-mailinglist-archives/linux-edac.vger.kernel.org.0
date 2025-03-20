Return-Path: <linux-edac+bounces-3372-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38C5A6A2D7
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 10:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E44462CC3
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 09:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1679222571;
	Thu, 20 Mar 2025 09:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natrix.lt header.i=@natrix.lt header.b="EKwtLk8w"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C111D1A5BBA
	for <linux-edac@vger.kernel.org>; Thu, 20 Mar 2025 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463697; cv=none; b=LnclvW7BnjrtH2kRdhx69Y3dBMqYEqkRXqZe+CoyfT1hyC7A2/Jge3wVKYwiRiocToz2RSGLiuDMMZyrj/MnVGZhMAkyucOETRQVEYoDur4XpizpeGC8w71wfzA6QdURIUu+lxd0yz7bL3NXCY+Uc/mcttw5Ir4jyBSNlRzkpAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463697; c=relaxed/simple;
	bh=kTqIBtVuKMkpjkbrGZ1VrKtI9l+PEFLfXwX57imiXDM=;
	h=From:Message-ID:Date:MIME-Version:To:Cc:References:Subject:
	 In-Reply-To:Content-Type; b=bYYT0eJ3A34DrDMJkOrmz2Bib84iIpBrSPd9ctGKorJHt3hzwjcc2Xlz10gs6JlU8okncsTPp5p9GlCM3LhkXM6seukO2p52sxG6euFVj0v/7CdicgP3dv36VcaUaLrSiuodeJ3SQCOnKDG85OsTCsePDBtv27sesExw5taxveQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=natrix.lt; spf=pass smtp.mailfrom=natrix.lt; dkim=pass (1024-bit key) header.d=natrix.lt header.i=@natrix.lt header.b=EKwtLk8w; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=natrix.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natrix.lt
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac298c8fa50so108263866b.1
        for <linux-edac@vger.kernel.org>; Thu, 20 Mar 2025 02:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=natrix.lt; s=natrix.lt; t=1742463692; x=1743068492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Osf8HXpWdLt0CBpvvD4g096wxy/sFMvsukrPLZHA0FM=;
        b=EKwtLk8w5lilVGfFonBFmtZqe4iUfDjAqoGPnzl5GacVSuv7SRsHv6y04t0/T4ijDM
         G7mNT1ysoe/O6Cum2T1DEGZmpTsIEYIgssuIKpVbEI+zIxgD6lLoruNwmdb38wRuadFp
         7qiAGRTOLQfFIf++tuRkbdu4zsBakj7ILzRwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742463692; x=1743068492;
        h=content-transfer-encoding:in-reply-to:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Osf8HXpWdLt0CBpvvD4g096wxy/sFMvsukrPLZHA0FM=;
        b=ukgTPW7M0KQ7eEYTaXkyJulD3FFJA+KgdOFBz8aCUGN0JH+3t1m8r+IOCt+hAn+DA8
         vrYRUrlV5MorNmTNWiVI9HXorVQ+L46nm+fgPhb9WAmMq9AMg/bH7v8VLB2IlTJZjVIK
         wFOO1Yo2ePIxh/W13Mfwwk0Bta/5kLpVN96/S0XkCxTbBN480GTkl/CZpml0Je4+3Z1I
         Bkuo0DX/mfdDdXchYYmT72qnsXtP4mYsSBPPVXmuvspEgPJhcu6cQCt1tjhJ1/7HCuxm
         hMMUKJYRTgwwk5fLfEUpGR2d7bhONBvEkaiXXheUDowfCRzuZcLDE5x+u/8hyEmojDC3
         t4bA==
X-Forwarded-Encrypted: i=1; AJvYcCUAXrAtyouu48KjB1asQfcwQ5YbcMF6+aYwB5+svz7fIYko0sz6/C8vXtgvOvRSN6jZ6nTEVjFygTZ7@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3SwpE/7whUB3f4QzdX0oA2fApaWlVxLJ2cOzKV9dWqCFYch9f
	Se4vY8SBoFgTHV/jxjY0KoO+7HSWnhmJsAkdykGwCAFj7EvTQfNc60SKkWb6LlaMK4egnPwg+rD
	A/cA=
X-Gm-Gg: ASbGncvK8kXlCn4ZJLWujJ2+6AmBRKMHJwwO3glPSUif3s8oSybJgE6cMusGaW3RsKM
	AF+xUNmTecsdRC7D6vayAuVM0oeqkmEVnpbqBwwFH2vVDCj/EXqmoODKZ2vlezkkiGcZARAtuvf
	ZXEZBO8xcLltrbZhPpQ9nUzfNNf/i8LDL98j1Ks4XjC/LgZTeyBHpTcUqw06A8UlenYWo6xJkcg
	6rJxG0iT6B1oBTDDKybKeCBaSHUOaU1YPr5ml+g2BzLgbn5gFZRVP0k0UyxZZuQJm6roHkJl5SW
	aBMz6bV5XpMX7kl5FlEEqT/wm14Qrksz21pN3jK1X2WXGRsH
X-Google-Smtp-Source: AGHT+IGdt83DtMzio21Z96gZyTC1qgMyypEES0vWj9nDrvfOX+biTdaAUSuArjt4qKnr9VErHe9hYg==
X-Received: by 2002:a17:907:72c1:b0:ac1:fea1:3b68 with SMTP id a640c23a62f3a-ac3b7f1ea26mr633325766b.41.1742463691352;
        Thu, 20 Mar 2025 02:41:31 -0700 (PDT)
Received: from [10.1.21.7] (beta.natrix.lt. [212.52.62.69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149ce8efsm1138616666b.102.2025.03.20.02.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 02:41:30 -0700 (PDT)
From: "=?UTF-8?Q?=C5=BDilvinas_=C5=BDaltiena?=" <zilvinas@natrix.lt>
X-Google-Original-From: =?UTF-8?Q?=C5=BDilvinas_=C5=BDaltiena?= <zaltys@natrix.lt>
Message-ID: <dbec22b6-00f2-498b-b70d-ab6f8a5ec87e@natrix.lt>
Date: Thu, 20 Mar 2025 11:38:58 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: yazen.ghannam@amd.com
Cc: bp@alien8.de, linux-edac@vger.kernel.org, mailinglist@reox.at
References: <20250317120702.GA7066@yaz-khff2.amd.com>
Subject: Re: Memory controller not showing half of the memory?
Content-Language: en-US
In-Reply-To: <20250317120702.GA7066@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I am also having this "half" memory problem - EDAC is showing 48GB 
instead of 96GB, however otherwise whole 96GB are usable by OS.

My system has:
1) AMD Ryzen 7950X3D
2) Asus B650 Pro Creator motherboard (AGESA is PI 1.2.0.3a Patch A)
3) 2x48GB ECC UDIMMs (KSM56E46BD8KM-48HM 
https://www.kingston.com/datasheets/KSM56E46BD8KM-48HM.pdf)

Kernel 6.13.6 is showing:
[    0.325894] [          T1] EDAC MC: Ver: 3.0.0
[    9.521853] [   T1336] EDAC MC0: Giving out device to module 
amd64_edac controller F19h_M60h: DEV 0000:00:18.3 (INTERRUPT)
[    9.521856] [   T1336] EDAC amd64: F19h_M60h detected (node 0).
[    9.521857] [   T1336] EDAC MC: UMC0 chip selects:
[    9.521858] [   T1336] EDAC amd64: MC: 0:          0MB 1:        0MB
[    9.521859] [   T1336] EDAC amd64: MC: 2: 16384MB 3:  8192MB
[    9.521860] [   T1336] EDAC MC: UMC1 chip selects:
[    9.521861] [   T1336] EDAC amd64: MC: 0:          0MB 1:         0MB
[    9.521862] [   T1336] EDAC amd64: MC: 2: 16384MB 3:  8192MB

or in summary:

UMC0: MC0=0GB, MC1=0GB, MC2=16GB, MC3=8GB
UMC1: MC0=0GB, MC1=0GB, MC2=16GB, MC3=8GB

I also has access to different system with AMD Ryzen 7950X and 2x32GB 
ECC UDIMMs, and it does NOT have this half ram problem, i.e. EDAC shows 
in summary:

UMC0: MC0=0GB, MC1=0GB, MC2=16GB, MC3=16GB
UMC1: MC0=0GB, MC1=0GB, MC2=16GB, MC3=16GB

RAM is Kingston KSM52E42BD8KM-32HA 
(https://www.kingston.com/datasheets/KSM52E42BD8KM-32HA.pdf) in it.



