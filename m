Return-Path: <linux-edac+bounces-4569-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF72B23E81
	for <lists+linux-edac@lfdr.de>; Wed, 13 Aug 2025 04:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3DF16E63C2
	for <lists+linux-edac@lfdr.de>; Wed, 13 Aug 2025 02:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6ED272E5D;
	Wed, 13 Aug 2025 02:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="En3aKEhH"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C36A26E703;
	Wed, 13 Aug 2025 02:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755053398; cv=none; b=VKKXa4TxnCbViA8Ucp42nXpcrmqEvK6NfEqdAcFOMS8v4iPqoTMDaKTclEGoIjONTyr1XouJalPt91K89T+80h+c/7UZN4XjrlsAfUuvtsbldkWOK+0U+RuZgryx1jfJsuCOJnOI95fXjgmEuzYO/ja0iM5T8IeKLRr56fjTb/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755053398; c=relaxed/simple;
	bh=ltKqSBZXfwtqcj+oKam9eDueOe346roobe+OsgG6koo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PyL+J/Zeed6e55QPQtdtI3HoUBuAwGnVZY5FbLFJ+S5MsWh/qZYrJpxdwYRDQDourNvwSNqyLCkTaL+AvIE4N+Y8ucR5HLSmB7j0Pi9ln2sewI+7eVS8DAKuxB+fpq7YnLnNiQoJWlfmoo0s78K+AThi0grKyLHKw406T2iOmLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=En3aKEhH; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-31f3b54da19so4202848a91.1;
        Tue, 12 Aug 2025 19:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755053396; x=1755658196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lQS8nEhwcYVup+sy9iJFHAcWvpA/jZF+5gx1aBAFcyc=;
        b=En3aKEhHvZDH3kePuWlnI3KxDHBGFFYWQ4SvNBbXdyv+9O1xICrvjqqCwxBy2N3VqH
         JACQDCDzL5exghjN31onNlIgAXzECkfEdo3HXnpEN3f0GnkCiJ0tBu5ZffkHyHwhDFbs
         d6UH/1B8UQrM/0EaLGurSJnwv2NVMRyawrvQ/nQlsZ8fSN+ajP/jZ/IJjtawK3Gxft7i
         DzLjubedNM8GCBDgqW+adc39aBawcmBSaAypwnNcaJDk0LqTP3AmcHG8qDnIo13q6EHZ
         eFCwWOyvk95hOunMGojS3EKJfs/sZq6H5/iEvJpofGfKOmBe8f0PhUxwSTqMrlDRX6+C
         amSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755053396; x=1755658196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lQS8nEhwcYVup+sy9iJFHAcWvpA/jZF+5gx1aBAFcyc=;
        b=dwEFlKNHJyKhMP/0+KQ+9yWdH2fObFAcfAoKM3mXodPaOLxzb/gjNGJ1Fv0KwRoT5g
         /LcoZzW1XUNU1SYDFEBDmflrYbltG5140bPXZ5YyiKrYlbf+DiLKjn1OqNgleLMWpAXd
         Z7GcFOtY6znRS9ssYTgnYFAKIfli47m6R93x0fp4CCYuoF7dyoEK1KS9FCSkRIMvaT3I
         cjH3P2CTfY+mC2yMHRvHdZKYWrBhypWTFu/CVldlymegWNbEFgSr7tL5DcLqDrQIyEDj
         BaRKM/6G//eXc9rFyReR13POl8CTzN8IU59dNM38UQsT1aQmnjVNcOmAdnNQGqVdrpgd
         ZamQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpp5sh5QOlyFjL94/yYamxBY9g1jvSC4VckZfV62cw7AE5CicQYCEe0hMvMEZDRCJp75T/BsiwEzk=@vger.kernel.org, AJvYcCWXIlEuqx549Pgr6BRpLWTSEPuk/ikjmWOzJl7QTpQDSuLwXs0hlGegsNXB7NpcxTtIZDzkb7cCJBcSQjGW@vger.kernel.org, AJvYcCXdL0iFcsPNeY9E/Y4nEyW5a3pg3nZxrmvIRhk36Ehbtss6JOuuFBllYngqoU5lhPP0HxPn5MDw@vger.kernel.org
X-Gm-Message-State: AOJu0YxxvIMtvDc+LFd17Jpkuvp+aNRKpeFxYH8ekZ0SjqBu/OaTpOfE
	xaZ7pbxiusLiByLS8pROr1qag5Y6VJg6Z+NNfAoKAf3ildHfGM8AiE3u
X-Gm-Gg: ASbGncurhOEyF/gwNwsFnIBpSpentsmYpno6dZpfY0jJo8mU9/ZlAT7q0/kXbI44hkD
	NqzAVbf9bYuX7lJ+cgRVpeQcCMOeDyqFeCkl6RUvM2EAFEKZgSDEdD0fdvws7427hvPZk6xtq0d
	0LshN7Ae4OAggTXdcDu310je7sjUwSk4DBU2AgG2O/+PIBLeMxWZXvL/sppAkkd7Twv4uxEXc+D
	U5dy+tdQxiWpN17/TaWf86Ioi+PiUwSqEhJKlB4jaJYQEm31dzZxQpMkLD+a8ewaMtJrWwhtJwr
	6JL2LL3z85RQenGpmlZ67LmRotVME1pyAR2BvbEOCK3JbmKlx1wj/UD6pdggoCBqQbJHOVsniv2
	bK0XQMYE3KH0N0G+AWDgpB5FWhzl1SVf0t0Qsz/uofzXX/fRUsrj3KCJr5hksHTHmR2zi
X-Google-Smtp-Source: AGHT+IFhTsVjvaAkfVJ663GzAql5Yv8cxjFsr6hoRD84O4VIwAig7x7xsHG/KN3bVF51/jYDe2q7ew==
X-Received: by 2002:a17:90b:4cc9:b0:316:e77:e2cf with SMTP id 98e67ed59e1d1-321d0ed0f13mr1991457a91.35.1755053396217;
        Tue, 12 Aug 2025 19:49:56 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321d1d981b2sm557590a91.14.2025.08.12.19.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 19:49:55 -0700 (PDT)
Message-ID: <9c4a655e-095b-45fe-b35d-c3f0ae6a9237@gmail.com>
Date: Wed, 13 Aug 2025 11:49:50 +0900
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL for v6.17-rc2] add a generic yaml parser integrated
 with Netlink specs generation
To: Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: EDAC Mailing List <linux-edac@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Ignacio Encinas Rubio <ignacio@iencinas.com>, Marco Elver
 <elver@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jan Stancek <jstancek@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Ruben Wauters <rubenru09@aol.com>, linux-kernel-mentees@lists.linux.dev,
 netdev@vger.kernel.org, Breno Leitao <leitao@debian.org>,
 Randy Dunlap <rdunlap@infradead.org>, Simon Horman <horms@kernel.org>,
 Akira Yokosawa <akiyks@gmail.com>
References: <20250812113329.356c93c2@foz.lan> <87h5ycfl3s.fsf@trenco.lwn.net>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <87h5ycfl3s.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[-CC: LKMM folks and list; this has nothing to do with the memory model]

Hi Jon,

On Tue, 12 Aug 2025 12:31:03 -0600, Jonathan Corbet wrote:
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
>> Hi Jon/Jakub,
>>
>> In case you both prefer to merge from a stable tag, please pull from:
>>
>> 	git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-docs.git docs/v6.17-1
>>
>> For:
>>
>> - An YAML parser Sphinx plugin, integrated with Netlink YAML doc
>>   parser.
> 
> OK, I have done that.  I will note that it adds a warning:
> 
>> Documentation/networking/netlink_spec/index.rst: WARNING: document isn't included in any toctree
> 
> ...it might be nice to get that straightened out.

After the merge, "git status" complains:

    Untracked files:
      (use "git add <file>..." to include in what will be committed)
	Documentation/networking/netlink_spec/

So, I don't think there is anything you can do in the Git repo side ...

We need to remember to "rm -rf" the directory after crossing this merge
point.

In theory, such "rm -rf" could be added somewhere in Documentation/Makefile,
but that would not work well with write-protected shared kernel repos.

        Thanks, Akira


