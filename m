Return-Path: <linux-edac+bounces-107-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7517FA951
	for <lists+linux-edac@lfdr.de>; Mon, 27 Nov 2023 19:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECE2E1F202CA
	for <lists+linux-edac@lfdr.de>; Mon, 27 Nov 2023 18:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67D03A8DE;
	Mon, 27 Nov 2023 18:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOD9gqhQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F8BD5A;
	Mon, 27 Nov 2023 10:54:00 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cfa7be5650so7754735ad.0;
        Mon, 27 Nov 2023 10:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701111240; x=1701716040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jBWX+tBMrXJ5sqEB3xXR9ubJgmb8By6ql2/SbCpyp68=;
        b=XOD9gqhQwvp0sQZjxtBE3AV5Wrx+wU9zVN+OHCqTbPmaAPFORwVMbwNpMvUswCay2p
         1ykV/VU2fksuC6jKHEa5jVBNFE2wOjKXBkXSPosit0ZtELhgyK6MfB5O8/FCMrkrFb5j
         7bVN2PCm4EAWJhNUPRru6AQKM+AhjPTvCbDsKSmFtyDQggWCI+lMpxT1y98yhoP5gisD
         4pQfJ3SK6R3dorNjDjDOlhDQz0gj5XYMNJNEfz6xein7N1mJhGUPHv7jSwsbgJW19uys
         DiLt6PdbGoM41ewcD8Nbiwh1Oo6/oQiIIIr+5I4z2xX0+JtHzBqP5sD/Moo0QZCf3kcP
         2GaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701111240; x=1701716040;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jBWX+tBMrXJ5sqEB3xXR9ubJgmb8By6ql2/SbCpyp68=;
        b=G+itHPcQmSh3l0DLO9uLlR6jS+iGgVEYb+cr8b4WNa3GPCvukeLCejkgUZGmhUi09+
         O/9GIntK/t7XqjJLlapjmTgItyQp+PkloMAXHnozuk6ah7pRNKLOY6mjOPa87Kj2CyNY
         bbZi7OfBXk0aErqEFfhxqUlBlo6LCo9bCjuQuj7E4doiMjSRRX1+WViIuLBMcmIYd7Eh
         jeRth4qTo7zLx2voKMIJ9jnjMt+4xTEIAGH6idcwPAFQy52Bmwg0uDnbVaDDAySyW/7g
         dPHebxaOwkNKWnAAo9J9uVJDdtbnlcKm27JVBSAebO4XVufpxGGNsnKYMONh9R0wUf1V
         2o1Q==
X-Gm-Message-State: AOJu0Yz6qBqUNXvMu36SV21b1kprK2/QQPNTrX2CgYezI2Vdihofr+o+
	/JmyZTVlkQ0UsXbOGZjw5fw=
X-Google-Smtp-Source: AGHT+IEL2mSrxdY6F1NZfGrVfQaW55mhAea9zjXPu/JNUyVOdoxUfVr1DXnyvjZYtrzmbHotbpt7aQ==
X-Received: by 2002:a17:903:183:b0:1ce:5b6e:bae1 with SMTP id z3-20020a170903018300b001ce5b6ebae1mr15606570plg.3.1701111239836;
        Mon, 27 Nov 2023 10:53:59 -0800 (PST)
Received: from [192.168.0.152] ([103.75.161.211])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ecc500b001cfc50e5afesm3145347plh.23.2023.11.27.10.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 10:53:59 -0800 (PST)
Message-ID: <95fc95c8-dac6-4137-a9cd-29f27da64e41@gmail.com>
Date: Tue, 28 Nov 2023 00:23:54 +0530
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver : edac : Fix warning using plain integer as NULL
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, qiuxu.zhuo@intel.com, james.morse@arm.com,
 mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20231109212157.1454726-1-singhabhinav9051571833@gmail.com>
 <20231127171435.GCZWTOe+DQSy4kkuKO@fat_crate.local>
 <dfb5b4cd-935c-445b-aaa7-bcce962a143d@gmail.com>
 <20231127183941.GGZWTibScFM4lgbqkG@fat_crate.local>
From: Abhinav Singh <singhabhinav9051571833@gmail.com>
In-Reply-To: <20231127183941.GGZWTibScFM4lgbqkG@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/28/23 00:09, Borislav Petkov wrote:
> On Mon, Nov 27, 2023 at 11:53:02PM +0530, Abhinav Singh wrote:
>> Hello, thanks for reviewing this. As of now this is only a warning issue in
>> kernel. I saw this post by linus
>> https://www.spinics.net/lists/linux-sparse/msg10066.html and thought of
>> submitting a patch. Also a similar patch of mine got accepted
>> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2560740.html,
>> so thought about opening this one as well.
> 
> Lemme try to understand what you're saying: just because someone
> accepted a patch of yours, then others should not ask you to improve
> your commit message so that it explains *why* a change should be done.
> 
> How about you put the gist of what Linus is saying in your commit
> message? Don't you think it would be a much better commit message then?
> 
> Especially if it explains why, even if it is the case that 0 == NULL, we
> don't want those in the kernel.
> 
> Hmmm?
> 
Hello, my sincere apologies, I wrongly interpreted that you were asking 
for a reason in reply rather than in the commit message itself. Yeah I 
agree putting a reason in the commit message will make more sense. Just 
to be correct this time, I need to put a reason why this needs to be 
fixed, in the patch itself, right?

Thank You,
Abhinav Singh

