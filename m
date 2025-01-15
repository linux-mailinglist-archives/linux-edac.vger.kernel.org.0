Return-Path: <linux-edac+bounces-2912-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B20EA11A3C
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2025 07:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A90287A3BAE
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2025 06:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE2322E3FF;
	Wed, 15 Jan 2025 06:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DdqgmN8G"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203CF22FDE0
	for <linux-edac@vger.kernel.org>; Wed, 15 Jan 2025 06:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736924392; cv=none; b=qROVEV7qIeaaCjw6knZ8yzQ+R83dHGqn7l1aqf5jRm2bpTIJ6yhYOHgRkoEBahWZkgTx4O0LtyQAlYtBa2EiabRUE7rBjlfQPIDrR2MAoADY/JTUkSmvF7uVUVjC6o43HM+Ri6aT4zTnTlvuzLDS1U5IJ9tUS21mG4h+CbMk260=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736924392; c=relaxed/simple;
	bh=LTLytc3rtZQclLny3QXl8MdxiYfVcD3zrYcSRV8eR8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uQMdwNBKXUEdEXlDTZa2DB5piDRv4G3nvudM3LyYLpHDF5R1RZVG7gkhRClRVPDCZemsBVJbh6u8JPnGRPeQhApERQVXJ6SRGjfWnp9nJKrcn8k2NMaENSs7hs8ejjhwrQpU7X3HshrmzXpzplMUbU/VooqA5Q6MlFmNiFSyuSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DdqgmN8G; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaeecbb7309so1190072766b.0
        for <linux-edac@vger.kernel.org>; Tue, 14 Jan 2025 22:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736924388; x=1737529188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+VfZyT/N2SmeTYzWdpxxp+TmK+Ki2TJpWYu1NUDYM5A=;
        b=DdqgmN8GLK7HQkwc8fnirfcRe9glxaA3ltKCInxr0lbeelw+ANbqhhv6CSIcYlN1ns
         +4rjWq4kbjq3SJWKbxWR7uVv4uT9BlbNFkh8BHS1voWEOJpYDUTGhY/Gdgkb3xRZMGJw
         lGcfNL7G93iE/UeDZgy/Wcs+qL4zqOreZ1SSUKAcN+YiOJvakr/TGa2D2JsXp4pg3uy1
         ny5Fsyn/csGSyAEnWd69T5Tg7COp7Px4JmZQNSCa1VB2ePL3ObiRmrU5aqkmMws4pqsV
         KIZXx8gR/OGI6jxNhLvu1jg/MruN1Q343TOPa32r7FUGhkEzIRwCKXvLr2BOamsAsK29
         SOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736924388; x=1737529188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+VfZyT/N2SmeTYzWdpxxp+TmK+Ki2TJpWYu1NUDYM5A=;
        b=tFWAQsOPuzw3hAQUtzaM7qmbjNk9En7nX7f/hWFfDiQPITrEHHaqsySCHaaY+vbLkR
         fcQSRz8PLf5iavXjoOyyjK5aad3OZ25G1t9AaEuO70gxZbUZ+FdXLVxpD71Gcq6uhDcZ
         QlxYs0/iY/jJ+efOdptcBnuJbSZN9m3nQQJRaa4U0IvUb2JUa7yE69178MoadyyxCdjS
         f//PrZgDU21ahDOJxhmU7fLVzQhvLNaSXA4peXM/ArXlWGFznP9SNV5GdoP+qAD2/PiV
         GLU4O3hGIU5lu0b2pfY1QjTnl4/d+OsduHE/Mjo66f9DkzeMrpHGq7uhTgmUvMzx43e0
         cgEA==
X-Forwarded-Encrypted: i=1; AJvYcCUVLm72ELB7TBqe6H2kP4XuH25HbFSRKfel6C4Eb2sK+1BmQVCOBuo5i2WIAHVvFzm9sneh50V6sGDB@vger.kernel.org
X-Gm-Message-State: AOJu0YwWBuSHnpRycqDHQyHXNxMuMldc/O59h7KoaWLIh0nbizIEkBKx
	ngssqXDUVs+USPUPzPBEujimHQuwkZp8h/PXgcZrG6rI5QKovuYQE1M/5avAnI4=
X-Gm-Gg: ASbGncvMnI372ZbFvz8rXcYJ00xa1XtMHBdTCJaoBIEAcVbwio68mF4qJeyIyd+3q7L
	vlfSGCCWy6nuE2pLowQT9mR7HYh+QN7AOb2TEimehxt6DmLVNVQYjeTBTbK9i8oV59yQU3KfXml
	oaQo20V3ihdWFDGyNCYwt8JmfvaanZgw1VGiean8imEu6Ii6SO/AllXY0H0GEa3pHLBozqMetn7
	E8PNfsVgjSADVxufTDu9U1Sl+TJymqyhMDN6WU0w5w+iJ7YN5C7iBJxPx9UcA==
X-Google-Smtp-Source: AGHT+IFlc2CsNFPg7fQldWMICDYInxqAcmmoryZXTfNMcY2QXMQZ8JZWBoJl4H5/WYTcfhVeC1rSPw==
X-Received: by 2002:a17:907:9623:b0:ab3:3892:b943 with SMTP id a640c23a62f3a-ab33892f542mr544265366b.53.1736924388354;
        Tue, 14 Jan 2025 22:59:48 -0800 (PST)
Received: from [192.168.0.20] ([212.21.159.176])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95b20b1sm712438566b.157.2025.01.14.22.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 22:59:48 -0800 (PST)
Message-ID: <4a7c5085-fdf6-4638-a43a-ca82f43c4ce5@suse.com>
Date: Wed, 15 Jan 2025 08:59:47 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Cleanup mce_notify_irq usage
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Cc: "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bp@alien8.de" <bp@alien8.de>
References: <20250114163722.34850-1-nik.borisov@suse.com>
 <CY8PR11MB71349D74B4BBB90E0EBDDD9989192@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <CY8PR11MB71349D74B4BBB90E0EBDDD9989192@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15.01.25 г. 8:37 ч., Zhuo, Qiuxu wrote:
>> From: Nikolay Borisov <nik.borisov@suse.com>
>> Sent: Wednesday, January 15, 2025 12:37 AM
>> To: linux-edac@vger.kernel.org
>> Cc: x86@kernel.org; linux-kernel@vger.kernel.org; bp@alien8.de; Nikolay
>> Borisov <nik.borisov@suse.com>
>> Subject: [PATCH 0/3] Cleanup mce_notify_irq usage
> 
> I tried to apply this series on top of the ras/core branch of the TIP tree, but there were some conflicts.
> Would it be better to rebase this series on top of the ras/core branch of the TIP tree?
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git   ras/core


Sure, will do. It's based off master curently

