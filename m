Return-Path: <linux-edac+bounces-1314-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3936390FD3B
	for <lists+linux-edac@lfdr.de>; Thu, 20 Jun 2024 09:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD4C1C2152B
	for <lists+linux-edac@lfdr.de>; Thu, 20 Jun 2024 07:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5997B42A81;
	Thu, 20 Jun 2024 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QblhbUMx"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2E6383A1
	for <linux-edac@vger.kernel.org>; Thu, 20 Jun 2024 07:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718866912; cv=none; b=HAHGajImCv2xMInQ71edj31ab8VoeD/VCVFfOW7SPNlxET2fYMMY9TuXan9PxC3zPh19HPowgjTynS6ZOfSThyD3HTFmt7W8ga2HYGDSnv0NjHlBr0++Y7VGLuBJVxAmV5YJVjbsmwBUqO/bBP+o//Zhnmfy2/AKaJu9jHctL7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718866912; c=relaxed/simple;
	bh=QQtpn/smuLvkV56HzwtCw5pAv16yzPHyp8Pzu33MgLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Io1madBwKG4Q6fMa1dcqZplKFm2lUCcLmflkNGJKQWly4B2VAk5YPrGM5Sze9jUdP8fU2vLhwNrpkubYLPhtEWuLSdw2fCUVLkfGLiAwRypnnH6VfhC+jRYL78rXAWYmCRH83HkBTNv2j2YRmNKTDvssYc0hnX4doEzYJ57rPo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QblhbUMx; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70601bcfddcso550245b3a.3
        for <linux-edac@vger.kernel.org>; Thu, 20 Jun 2024 00:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718866908; x=1719471708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibiGIkIJozxVRVQ0W/R98N1EhJWcdntoJXMh9zcTPvk=;
        b=QblhbUMxOb1EKUTdUqmUDY3FV1Vsi8Ticw9Enu5ovjH1M8rvnezK5N5+MBTJTr8nWd
         +w62OmWUXQOT2PYt8Mhkyy0As2zvec74qCrlo2zc2VfAUlQP0ulUYmrh0O1rO523Kl2A
         62bs9NABEBqsDEUOvk3rEovXe/labGP3aGUwzXmo2pphkVzvnkdXxmVGyquT/S8KIKAg
         c3hWJf6Bms+TnX5J+fFCpKk6TJZrLnmJTSUDcBYXY7IhPdOoN6kuqo9nVufE0y0Lig+M
         ZBjs21zpbmmBsqHwcsA3ZrfWcJC/uSt/GEieq5YvIETydgGKAplNjtXM887pcxFY9XKc
         6GTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718866908; x=1719471708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibiGIkIJozxVRVQ0W/R98N1EhJWcdntoJXMh9zcTPvk=;
        b=CVY+xiIwdqc5Fxo1eOZ3PS3e8UCuQ7eZhdPEnZYWGSn1MG30Rs6WZd6lad+cD4YXbm
         UmOCAmwkKh8k+63qC2fSW4MzoEw9PUff/V83kQFKzzs5qup9jkvY2bzOMYH002w8n4TB
         tsQwVQb6PHeRQZ9h4a0nTX/e6kjrtH8k33FW0zfAm11k4aH9xybGMWE/D5Q+BQTu3XW1
         cut7D/bbG8G398w3p6GHcwGQoncVMfVJ+HP5mcXrOUshJGDz2x2mBKxyZAK7uqC2JJNI
         f0B7J4dD9uZ2/cA6SYvLYD7gb5TxUzYEIafeHvvjIvudvrpHPnf6vmdObJtZttMjZvIw
         l8aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUtSYAWHI6YioGPrOdRLehVrLY19xPSqjNMYhE8R7YbqDSKJ6izab/1HiOetED1vjkDKpKIv6GYLBr4a6TCCdc1HcsKpkYT5HeKQ==
X-Gm-Message-State: AOJu0YyDsjEp+/5pSnvCRpd90Wr7cH6RZ4w0iScMN68cM2x8Xp6msU5f
	p49rr+ksbkJS4L5V9EfmnyMU/72NbgwZRKoACwQE9FQ9Cf5X6ji3vWk4sCwaKes=
X-Google-Smtp-Source: AGHT+IHDyzJcEghpRsfweA27T0zs7L2wOX7octNPLrUWsJgbfYtwABrlONIhyLuVS3lq1wnWvWgthA==
X-Received: by 2002:a05:6a20:ae86:b0:1b6:dd1e:da3c with SMTP id adf61e73a8af0-1bcbb152c98mr4585211637.0.1718866908610;
        Thu, 20 Jun 2024 00:01:48 -0700 (PDT)
Received: from L4CR4519N7.bytedance.net ([2001:c10:ff04:0:1000:0:1:7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9c85f4229sm8446535ad.156.2024.06.20.00.01.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 20 Jun 2024 00:01:48 -0700 (PDT)
From: "$(name)" <qirui.001@bytedance.com>
X-Google-Original-From: "$(name)" <$(mail address)>
To: tony.luck@intel.com
Cc: bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	qirui.001@bytedance.com,
	tglx@linutronix.de,
	x86@kernel.org
Subject: RE: [PATCH] x86/mce: count the number of occurrences of each MCE severity
Date: Thu, 20 Jun 2024 15:01:40 +0800
Message-Id: <20240620070140.12854-1-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <SJ1PR11MB6083AC9C721D46D3CCF9846BFCCE2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <SJ1PR11MB6083AC9C721D46D3CCF9846BFCCE2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/19/24 上午1:35, Luck, Tony wrote:
> 
>> In the current implementation, we can only know whether each MCE
>> severity has occurred, and cannot know how many times it has occurred
>> accurately. This submission supports viewing how many times each MCE
>> severity has occurred.
> 
> Is know how many times each case was hit useful? The original commit
> for this code said it was just to check coverage for the mce-test suite.
> 
> 4611a6fa4b37 ("x86, mce: export MCE severities coverage via debugfs")
> 
> So you either covered a case in the severities table, or you didn't. Does it
> help to know that you covered a case multiple times?
> 

In the fault injection test in the laboratory, we inject errors multiple
times and need a counter to tell us how many times each case has
occurred and compare it with the expected number to determine the test
results

In the production environment, the counter can reflect the actual number
of times each MCE error type occurs, which can help us detect the MCE
error distribution of large-scale Data center infrastructure 

>> Due to the limitation of char type, the maximum supported statistics are
>> currently 255 times
>>

How about changing char to u64, which is enough for real-world
situations and won't waste a lot of memory? 

>> Signed-off-by: Rui Qi<qirui.001@bytedance.com>
>> ---
>>   arch/x86/kernel/cpu/mce/severity.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
>> index dac4d64dfb2a..a81e34c6e3ee 100644
>> --- a/arch/x86/kernel/cpu/mce/severity.c
>> +++ b/arch/x86/kernel/cpu/mce/severity.c
>> @@ -405,7 +405,7 @@ static noinstr int mce_severity_intel(struct mce *m, struct pt_regs *regs, char
>>                        continue;
>>                if (msg)
>>                        *msg = s->msg;
>> -             s->covered = 1;
>> +             s->covered++;
> 
> Wraparound sets this back to zero. Should this be:
> 
> 	if (s->covered < 255)
> 		s->covered++;
> 
> [Is there a #define for max value in an unsigned char? I could find one. If there is,
> then use that instead of hard coded 255]
> 
>>
>>                return s->sev;
>>        }--
> 
> -Tony

