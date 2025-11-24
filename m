Return-Path: <linux-edac+bounces-5523-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6B2C80C1B
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 14:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CBDB3AD71A
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 13:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0611FF7C7;
	Mon, 24 Nov 2025 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A9nMx2ln"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E3119E968
	for <linux-edac@vger.kernel.org>; Mon, 24 Nov 2025 13:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763990690; cv=none; b=dlE/iAZPrhmhtPvjZnpCS0HhQSkQj6DKZAztzwX+cb4r7BfS4YZ/W3sgjWSC47bSTD04WW7xAx/9fgUYMGdbIrYKxqISkoUWlxQRQyci0HNIiqbK3Dn3qLkHmoUN3/q35vg4o8vUpJP6zNG1FP5e3vq2Zu3eaS/QhIa/TgWIgxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763990690; c=relaxed/simple;
	bh=lMEOyHnkbVWPM/ndwnXY4A47ZzmMiFHGcwoHhgSFERc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8Xm0PF6Nz/uG0hdb2Flo7yVWYTUzCyA2ioRznnS2RVQ7K8ZNPWe+bdgyaND/yhmG2+F+Izw+uqvVjoHSNArlYHphxkD/POYMIhUWy/AJwZ7gX3oBP5PZuaZOtBdrssU8fmDafuZTnrt/DaNPmILCSMkbd9dYAF4jML5TiYmQjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A9nMx2ln; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7277324204so720055066b.0
        for <linux-edac@vger.kernel.org>; Mon, 24 Nov 2025 05:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763990682; x=1764595482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oy2+uqiCTiltZ9scww5QY+J+CAdmsqwN2zmkNTLOsrQ=;
        b=A9nMx2lnwR+wILVmPxj+yaMkp08/sOdd+0tbF3pHsYEIVKwr7RyqjLIaKdAVLkWcPO
         NGf4vmrJTxYGnLxD2HBpc1EhKnMgijIgHsCDuixBQ4kT/LZnhDTV+DitmINIOy7VVJm8
         9XtA6PvU4rW86N3yWIzHVm4Fz2uw3RWMIjNc9ANCVsQUvlR0uapqrEGIdTgsAmlYpa9n
         nafUqtrt5jocoTgUfS0YXMSIVnX6f6SfuFZY+5t5wo/ll0uhFtOp1iQDBbGFB6Gs4pPu
         anCVKHM0AHw2PPxvhy/hOTauiJWg0r4Ii/ii7ONx8YAkEPqbJVgm/dUKdBcpDu+/kwDx
         VfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763990682; x=1764595482;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oy2+uqiCTiltZ9scww5QY+J+CAdmsqwN2zmkNTLOsrQ=;
        b=LX+xXoRcgYqCCecTmEctQN3Yl0eUcr+vlOhrqjH1NTWIbPN9StNl0eJDWXh6JsJtaQ
         r8YLu5tGxeGfJVBQCrlYqMd8X51qFoTf9P1bxFcig3F2WxjvSk3YLVth7AMBV1K0HOkW
         TZHmS5VGmxnKvvjE7JRIhVnh8r7vYHeioFNQWWhLk+rqpOVMl79AV99dCqKo0lD229nT
         aY2cATrAZgupi7xmyMC0gJWFtgnrMOfLEW1+sxexfL3w6lmzZ8SRvvPM/qPWizfDBdLt
         DE0P/k6VYfNeW0t/FJyfq6PYZswQZTNHr75rGLophQPoIfzVgtaLpwvSQw076m33Nuku
         L+7A==
X-Gm-Message-State: AOJu0YxymdG54aMFl2aOhYvOhOqF3UKEEOWJLm7yB+Y+QWH+AeJH5ZvG
	pLOP4YN1QTV99ab+T1p//LIoe8JWz+ILRTDo4O1Rl+MErt3OfLle8fGS2CIH67kq6ms=
X-Gm-Gg: ASbGncv6HovYFvBNLVwxLkChcpc9ns+VhWswR8Wh+aXOWnlq4yirdLXwr1+H2NQGRJe
	/0I1iZtUiJXCeV9wduJAMJVP95dmqAi2kzZCi52zK9EJq+RX0aQ0/qD/sN1QaN8CNDFAH/VJf/g
	OYd/YtNM2NeiNBrTCRr8O+ZC05XbB27DFCRSOj4MM72IyaIMWhUNcrKEDlN/5XmYZ7ABwfYemU9
	eyyuaJTBQ1Tw5wTeQnlLBWadoZwAzi6CZIumdabb0N9YOuKKKPEL06EwyKoTvm5vZsvUO/jrDIe
	9UTRMm2wTBYJ1tyOUw5OaIeBI8IdU1aghP02gqhbRt22biL4+mxWKGoucHglyk2ienY22/x4BWi
	UuFVMMSuIvXSJUOttFmcAwfpW0M1z3bf/Dh9tIhmL3Ro2adoHe+R+bCyr3AwH+IVRmBaEE0jiHC
	PJZw5/GH6399DfxDacxmH+t/9kD9THlPlbFSLi
X-Google-Smtp-Source: AGHT+IEstfdLVTFWGcOCZvgMkdyrOXa0hyiqfGHhB2gO1pIrdQwR/YDCnzirUr716Iw2duTw8DmyqA==
X-Received: by 2002:a17:907:3f2a:b0:b76:36ed:8a7e with SMTP id a640c23a62f3a-b76715b0db7mr1208333766b.27.1763990682297;
        Mon, 24 Nov 2025 05:24:42 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [85.187.216.236])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d55d7fsm1292288866b.21.2025.11.24.05.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 05:24:42 -0800 (PST)
Message-ID: <3e191e87-5b7f-49e9-b794-eb244d478c56@suse.com>
Date: Mon, 24 Nov 2025 15:24:40 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] RAS/AMD/ATL: Remove bitwise_xor_bits
To: Borislav Petkov <bp@alien8.de>, Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yazen.Ghannam@amd.com
References: <20251124084011.1575166-1-nik.borisov@suse.com>
 <aSQeD-RSZxeuPj_h@google.com>
 <20251124110526.GAaSQ79mo0yx1h1Xxm@fat_crate.local>
 <aSRJdskInHGmbjIo@google.com>
 <20251124125249.GDaSRVIapy2dmis28p@fat_crate.local>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20251124125249.GDaSRVIapy2dmis28p@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/24/25 14:52, Borislav Petkov wrote:
> On Mon, Nov 24, 2025 at 08:03:02PM +0800, Kuan-Wei Chiu wrote:
>> On Mon, Nov 24, 2025 at 12:05:26PM +0100, Borislav Petkov wrote:
>>> On Mon, Nov 24, 2025 at 04:57:51PM +0800, Kuan-Wei Chiu wrote:
>>>>> Both LLVM/GCC support a __builtin_parity function which is functionally
>>>>> equivalent to the custom bitwise_xor_bits() one. Let's simplify the code by
>>>>> relying on the built-in. No functional changes.
>>>>
>>>> IIRC in some cases,
>>>
>>> Which are those cases?
>>>
>>> Do you have a trigger scenario?
>>>
>> I did a quick search, and I believe it was this kernel test robot
>> report [1] that reminded me of this compiler behavior.
>>
>> [1]: https://lore.kernel.org/oe-kbuild-all/202501312159.l6jNRaYy-lkp@intel.com/
> 
> Interesting, thanks for the pointer.
> 
> @Nik, just use hweight16() but pls do check what asm the compiler generates
> before and after so that at least there's some palpable improvement or gcc is
> smart enough to replace the unrolled XORing with something slick.
> 
> Also put in the commit message why we're not using the builtin parity thing
> and quote the link above.
> 
> Thx.
> 


So the custom function one results in the following asm being inlined i.e 4 total copies:

# drivers/ras/amd/atl/umc.c:59:                 tmp ^= (val >> i) & 0x1;
         xorl    %ecx, %ecx      # ivtmp.157
# drivers/ras/amd/atl/umc.c:55:         u16 tmp = 0;
         xorl    %esi, %esi      # tmp
# drivers/ras/amd/atl/umc.c:253:                temp  = bitwise_xor_bits(col & addr_hash.bank[i].col_xor);
         andl    %r13d, %edx     # col, tmp249
# drivers/ras/amd/atl/umc.c:59:                 tmp ^= (val >> i) & 0x1;
         movzwl  %dx, %edx       # tmp249, _387
.L3:
         movl    %edx, %eax      # _387, tmp250
         sarl    %cl, %eax       # ivtmp.157, tmp250
# drivers/ras/amd/atl/umc.c:58:         for (i = 0; i < 16; i++)
         addl    $1, %ecx        #, ivtmp.157
# drivers/ras/amd/atl/umc.c:59:                 tmp ^= (val >> i) & 0x1;
         andl    $1, %eax        #, tmp251
# drivers/ras/amd/atl/umc.c:59:                 tmp ^= (val >> i) & 0x1;
         xorl    %eax, %esi      # tmp251, tmp
# drivers/ras/amd/atl/umc.c:58:         for (i = 0; i < 16; i++)
         cmpl    $16, %ecx       #, ivtmp.157
         jne     .L3     #,


Whilst with hweight, if the cpu has popcnt it will be 2 instructions - popcnt and an andl:

# drivers/ras/amd/atl/umc.c:243:                temp ^= hweight16(row & addr_hash.bank[i].row_xor) & 1;
         andl    %ebp, %edi      # _321, tmp221
# ./arch/x86/include/asm/arch_hweight.h:19:     asm_inline (ALTERNATIVE("call __sw_hweight32",
#APP
# 19 "./arch/x86/include/asm/arch_hweight.h" 1
         # ALT: oldinstr
771:
         call __sw_hweight32
772:
# ALT: padding
.skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
773:
.pushsection .altinstructions,"a"
  .long 771b - .
  .long 774f - .
  .4byte ( 4*32+23)
  .byte 773b-771b
  .byte 775f-774f
.popsection
.pushsection .altinstr_replacement, "ax"
# ALT: replacement
774:
         popcntl %edi, %eax      # tmp221, res
775:
.popsection
                                                                                 
# 0 "" 2
# drivers/ras/amd/atl/umc.c:243:                temp ^= hweight16(row & addr_hash.bank[i].row_xor) & 1;
#NO_APP
         xorl    %eax, %edx      # res, tmp222
         andl    $1, %edx        #, temp


So yeah, much better IMHO, unless there is some hidden latency in the popcnt...

