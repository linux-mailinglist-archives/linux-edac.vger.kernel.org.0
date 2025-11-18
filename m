Return-Path: <linux-edac+bounces-5456-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B66C69693
	for <lists+linux-edac@lfdr.de>; Tue, 18 Nov 2025 13:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id ABA162B294
	for <lists+linux-edac@lfdr.de>; Tue, 18 Nov 2025 12:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B7F30FC11;
	Tue, 18 Nov 2025 12:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IiLLkqGw"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5CD2EBBB0
	for <linux-edac@vger.kernel.org>; Tue, 18 Nov 2025 12:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763469373; cv=none; b=LARK/81j30tft2wlVXzs1BfN80MSVrDX6QQd9ZZcPkFT25UlwEwwVpI5Vvk0Iraj0yGPf/QU9SGZd7KwxCIvV+6BwLJkwbdxQzPb3U3xVRPSXi1asHGbQDinqdajEm3i4zxxl8bEGnQ2pGGF9TqyQF3W3W3tcueKM8eEcrez9tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763469373; c=relaxed/simple;
	bh=0iWpzVXsZKiVN4d2mtmRQaxtgLONv8D8fhWhkLMNg3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HxOC78j+0AA8Ks1Y4zS/9pNFQO51GSuCGIoTpcwt8Qd8W28P6qKYHsXhl8xd6xyIH8f3X6milAKQ1dG1mKwwl2Dji3JgqRObPZj0jDpJOOQmTr+FaeH4S8Ft/caIk8G6fMou1lleoivYq9KovlgU9Af//lsE0Zf9IX6N7dnN6gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IiLLkqGw; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64320b9bb4bso5335291a12.0
        for <linux-edac@vger.kernel.org>; Tue, 18 Nov 2025 04:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763469370; x=1764074170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ptuODa4HVKL9pivjZg7Gc+9oPprywMKVOlCQNP8yDM4=;
        b=IiLLkqGw/3AzqvNgw/sejiHMK1AHMHK1/iW+DaOcDtjs/Jv3vZX4U8fa1Mi++J4fkt
         odBlrahg17lduy+5KCEInB92Jf89MRGVp8f0M/wV22Bzw7qw5Z2zyLyr20wut7V3SXtH
         M1AompvCV+cmkoJgmtMSho9pmeuVcEfrSaCUAq4aFYU78G6rNH2pROUCmmZBEKq7rIhE
         ZYRDr7RLYVlFrSO0brLLRAF1kc79csA70DieDqWaZTJir9BufeHvbObsV4OB6Xq4D1IR
         A9u2YLosAVCFs5rjA9UunOEoaIY/CcjqPFkkHOntQuXu6LpYDBg6hhZwh1HDxwT7qewk
         iRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763469370; x=1764074170;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptuODa4HVKL9pivjZg7Gc+9oPprywMKVOlCQNP8yDM4=;
        b=hokY7qULj/svsPQy+WvZN9OikcLZB+/xYWJfIh5H64LJGeXZPIJZQTR/uJZ+kFh+cr
         DD9fgz8qsIH+IKHkhpvHB6db3JKtjpc5TAr8VoHPcb+TadBZOSCa22Z+SR9VhKs/mo4d
         eWNDIKO9nSVPsByho2sVbZIPh1j/Ojr2P+fdnD9XLDstfcdyUiZ8apNRjH4DiNZ4MSI6
         5vupffkBJtss9CID8I6tp8u+tlgSbScgk3CiNKE7sRoRdelwMyWaepMr4gsmFCqLcbk3
         FwAk13aAmfEKF8qMPdLDJ5OZw1Mk2jTznPXVO38fd9MYKmIpW0BGndZntQAdXztQtV+l
         vIsg==
X-Forwarded-Encrypted: i=1; AJvYcCUYRdzccH7XWh7Wy9gjgkhhL5webcWjBPNB+utV5VNqmoLpplCsrLTtD4oYSGH8ZrbrcpAb+clMQQUw@vger.kernel.org
X-Gm-Message-State: AOJu0YytfK4ENOKpwbVCCRoL+XsWNqj8uOv9YVimYYYHxS1DtWF/wEPH
	9fz0WzjswdrjBuM0mQg3vn0ewLOGs+RKXnL9kIpHbf25ggZhk6yy2nZLG78H6U5E4S8=
X-Gm-Gg: ASbGncv056Kzmx9PHCZqJCZwB8Igu4UMeanF3NwpmBaTpy+u8S5fX8zcPgTc53voGpw
	s+HtSpg+vrD6VgFJfahnYxE9CpmyalF5YycrmogqAA9aY65DTEbqAoH5H3LlTQ2/ud1ST1df/+M
	vBI9MizIhRKBnfPzUs1xAPHPNFId39nNhNGIeoVdIY6+bP0BLPxpkon+b/QXX8qNZzMBh6ucJOx
	7q3Eamdfj1wltu0vzAPlDTokub7FknAkBwF8yjQg13oenC12vLhZ9XvnON3SVMNURGaN5LEz8M3
	hU1yHXwh4FkAxcesTz2E/upjxXCmbhYYkHoBMtyZQjZdEFmjCuEYYv4fzs7NYSsP7Vo6jh1W24n
	1woIUvfbIux0N53R5LkFxuVezSxfgdPs5Q7lu7C9Tp5cvqkn5cK2H1bIWEedkTk6P1yFQjtDSQd
	V6AX1O3/8WULE9DypusUr9rtRCqQ7k+7U+QP3G
X-Google-Smtp-Source: AGHT+IFeCY5ibK4wSr3It0W5OBdls1U/4voZxeNgehA4y8m3pfQiXUVT92WBk77rRFk7crgZHXQIqA==
X-Received: by 2002:aa7:c689:0:b0:643:130b:c615 with SMTP id 4fb4d7f45d1cf-644fe782915mr2035419a12.6.1763469370019;
        Tue, 18 Nov 2025 04:36:10 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.139.92])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a3f961bsm12774417a12.14.2025.11.18.04.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 04:36:09 -0800 (PST)
Message-ID: <edfc3212-dc28-43a5-9d9d-c838d253ea88@suse.com>
Date: Tue, 18 Nov 2025 14:36:08 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RAS/AMD/ATL: Remove bitwise_xor_bits
To: Borislav Petkov <bp@alien8.de>
Cc: Yazen.Ghannam@amd.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251113111125.823960-1-nik.borisov@suse.com>
 <20251118123352.GJaRxnsHRC6KcbQanQ@fat_crate.local>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20251118123352.GJaRxnsHRC6KcbQanQ@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/18/25 14:33, Borislav Petkov wrote:
> It is bitwise XORing the bits. That just*happens* to be the same thing as
> calculating the parity modulo 2.
> 
> Unless you wanna say something else here which I don't grok...

Fair point, but bitwise xor is the lowest possible operation, I guess we 
care about the higher-level effect, which is calculating parity.

> 


