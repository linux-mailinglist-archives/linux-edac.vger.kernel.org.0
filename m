Return-Path: <linux-edac+bounces-3744-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64511A9C97A
	for <lists+linux-edac@lfdr.de>; Fri, 25 Apr 2025 14:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C031C0003C
	for <lists+linux-edac@lfdr.de>; Fri, 25 Apr 2025 12:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84316255E44;
	Fri, 25 Apr 2025 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OqN34+0y"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0B52550D8
	for <linux-edac@vger.kernel.org>; Fri, 25 Apr 2025 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745585494; cv=none; b=ZGSQlSDgcXjSP3Ierx/f6zpKIG6wq1UGmRDzGd/Np30pMLUrcwZW/QGz+2zdF3XQKMBOFAu4xqqlnXJ1EReRPBwsW3L00j7xVmlrdcDE7PqG6PY4R93NscK1OYAvREpIrPnQJQZds+w1ExcE/fDTQrEnBDduO24VXSKEApF+6WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745585494; c=relaxed/simple;
	bh=QwWtNokkfVuIeRXynko9qQzQz/Rs9NiYpTsLbebSHY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b50JamIlOCcYmH0puC5e7frEiyMnIfJqa4aldTT21DcapXqEe2+kD6PV1GEHiO9O+6781nJSzsBNK8Q3wm3YnOliRCXFSRyXNSI1F5mw8wAXKiUaIbLnPAHKOE6ZXu8yF2eDx41fN3KG19bBuAhuY59EmkIBUM1+Lyv0aWKV+Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OqN34+0y; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5f6222c6c4cso3568327a12.1
        for <linux-edac@vger.kernel.org>; Fri, 25 Apr 2025 05:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745585490; x=1746190290; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QwWtNokkfVuIeRXynko9qQzQz/Rs9NiYpTsLbebSHY4=;
        b=OqN34+0yR35o52UVOdveFAw7T8r4cuznr0RWUTaDk7WG6xFse1iBGGIgl1KmY+RJ6n
         x1RrM0PF1tvfEkrQWimn+3b/RqI7DKQzq8yfTNK8aoLecNkymuoHWeI1cwkpjIlS5nsl
         aALgKTBAowuIvMw6+Jf5+dJTKalr6l96NPjCeCy8JoADTV2DR/14bB2TFs+ylGaB9Yq2
         rA/CiDWdbybCxJMeBlft8rJbfI9wVCfVk33PlmPXNAbEEovl7d7ndUIlwyf5zcsPCgRr
         p4BsROr/K9T8ilob7cks1OCYVRyVfHFceaxNhbNpALPAFIZ+62+hwzlB2fgtbQZGyw8s
         R6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745585490; x=1746190290;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QwWtNokkfVuIeRXynko9qQzQz/Rs9NiYpTsLbebSHY4=;
        b=DZDnlTwmttdjvQ6vjNhB0e//BrE0t2DEXhr6F7dfMMr5pFmf/+1Lsps0iNsOSTura1
         fU5Sso3uJ8L3celzFFENQY17cXLCJI6AqDIp+NdqoFoDm33vXAvyCQUdHZjSoJqjsRnQ
         dDCAFn+RHPUyMS3eSR7V5Xc245wPl1iF2IXzxwifleVYi1ZoclbPDBxEKyIdi/Mdy2f6
         TbKGMDJNKTR5jZOARbahRSSywvKw4BMagG6HpmKYCaBzYYvleoWk8m2zAV+mgxCto/7G
         7ZDrbRt2BDf/CSpZ3bmJDXguHpCAqN1yJrzPcr4kZg+EzNTXwBXnpxsTLwg9P3Nvvu+D
         LO/w==
X-Forwarded-Encrypted: i=1; AJvYcCVhxMwRZ+RZAkHAmHpzc+MCHZbBgoHy6IjP9JiHO8ekURcu0GB/AVaxe0RXyzAJtBC5dUoDLJIZj3rx@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh6ZBktV5c3hiRP45qMN8OvB9NSIh4ajQ3LYZxSA1hrJ+2WdBd
	8/5gPdnc38ponCwyvxrupRdepKmfpVRAZNkxwq2d9rn+MTBdrt5AFDqvmjd62QE=
X-Gm-Gg: ASbGncuNXJqbsr9VLD4fyV5DfYE3faMY+JGuefjBsLQyp3iUHUZqxH9Tp1HK990Mpv8
	f77WcVtFPAhCLa/b9bcsRjQFTtcBAgAzNNS5HuMUzFd0VTNf9ZSHES4mSbWWfxrZ/ntQ6ABzvtk
	9LqcxA0hDORwEUXNlgQB6ri1DujBvOakOhtY8Dx97fSBIYpH/IMmc/pADsZ+KF9puYi4z4tVNWK
	s1pQjdOD6Ak/TltHm5fZoXUFe4quuCvzz9ucbztsUwM02d2oCS00RfCH0VlKlmyYIRL1qJIUBKo
	cxbWQY/uQzLvPtdtQ6bUenjxUDq01smyTpnNZ7Nk8gzxe4QXWNMePGneK6d4S1+07wNqPVsWtFd
	Qm2T1oKECk7EBQISiWUwmfHpRy3TVLQIYwfxSND0uwOS2yv7kyAEGqhzttH88QwJuBQ==
X-Google-Smtp-Source: AGHT+IFNK5z5L+OZugp/JrHsD/ek2grtIVBstAXX/s7dAzj21zA8Jl8YCBMRL8UDCGc4m8dgmm2D+A==
X-Received: by 2002:a05:6402:26cf:b0:5e6:bba0:6778 with SMTP id 4fb4d7f45d1cf-5f72343464emr1737937a12.23.1745585490047;
        Fri, 25 Apr 2025 05:51:30 -0700 (PDT)
Received: from ?IPV6:2003:e5:870f:e000:6c64:75fd:2c51:3fef? (p200300e5870fe0006c6475fd2c513fef.dip0.t-ipconnect.de. [2003:e5:870f:e000:6c64:75fd:2c51:3fef])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7013ff81dsm1302428a12.24.2025.04.25.05.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 05:51:29 -0700 (PDT)
Message-ID: <35979102-2eb2-4566-b32a-f2b02ded8ae6@suse.com>
Date: Fri, 25 Apr 2025 14:51:27 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 21/34] x86/msr: Utilize the alternatives mechanism
 to write MSR
To: Peter Zijlstra <peterz@infradead.org>
Cc: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
 linux-hwmon@vger.kernel.org, netdev@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 acme@kernel.org, andrew.cooper3@citrix.com, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 wei.liu@kernel.org, ajay.kaher@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, tony.luck@intel.com,
 pbonzini@redhat.com, vkuznets@redhat.com, seanjc@google.com,
 luto@kernel.org, boris.ostrovsky@oracle.com, kys@microsoft.com,
 haiyangz@microsoft.com, decui@microsoft.com
References: <20250422082216.1954310-1-xin@zytor.com>
 <20250422082216.1954310-22-xin@zytor.com>
 <b2624e84-6fab-44a3-affc-ce0847cd3da4@suse.com>
 <f7198308-e8f8-4cc5-b884-24bc5f408a2a@zytor.com>
 <37c88ea3-dd24-4607-9ee1-0f19025aaef3@suse.com>
 <20250425123317.GB22125@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20250425123317.GB22125@noisy.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------07IxI3FeUVVif9J0hZIyhP9u"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------07IxI3FeUVVif9J0hZIyhP9u
Content-Type: multipart/mixed; boundary="------------l43kLZ1qANrhEdych36notzD";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
 linux-hwmon@vger.kernel.org, netdev@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 acme@kernel.org, andrew.cooper3@citrix.com, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 wei.liu@kernel.org, ajay.kaher@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, tony.luck@intel.com,
 pbonzini@redhat.com, vkuznets@redhat.com, seanjc@google.com,
 luto@kernel.org, boris.ostrovsky@oracle.com, kys@microsoft.com,
 haiyangz@microsoft.com, decui@microsoft.com
Message-ID: <35979102-2eb2-4566-b32a-f2b02ded8ae6@suse.com>
Subject: Re: [RFC PATCH v2 21/34] x86/msr: Utilize the alternatives mechanism
 to write MSR
References: <20250422082216.1954310-1-xin@zytor.com>
 <20250422082216.1954310-22-xin@zytor.com>
 <b2624e84-6fab-44a3-affc-ce0847cd3da4@suse.com>
 <f7198308-e8f8-4cc5-b884-24bc5f408a2a@zytor.com>
 <37c88ea3-dd24-4607-9ee1-0f19025aaef3@suse.com>
 <20250425123317.GB22125@noisy.programming.kicks-ass.net>
In-Reply-To: <20250425123317.GB22125@noisy.programming.kicks-ass.net>

--------------l43kLZ1qANrhEdych36notzD
Content-Type: multipart/mixed; boundary="------------IalltgkvDsSESyH6wpAYJhIj"

--------------IalltgkvDsSESyH6wpAYJhIj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjUuMDQuMjUgMTQ6MzMsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBXZWQsIEFw
ciAyMywgMjAyNSBhdCAwNjowNToxOVBNICswMjAwLCBKw7xyZ2VuIEdyb8OfIHdyb3RlOg0K
PiANCj4+PiBJdCdzIG5vdCBhIG1ham9yIGNoYW5nZSwgYnV0IHdoZW4gaXQgaXMgcGF0Y2hl
ZCB0byB1c2UgdGhlIGltbWVkaWF0ZQ0KPj4+IGZvcm0gTVNSIHdyaXRlIGluc3RydWN0aW9u
LCBpdCdzIHN0cmFpZ2h0Zm9yd2FyZGx5IHN0cmVhbWxpbmVkLg0KPj4NCj4+IEl0IHNob3Vs
ZCBiZSByYXRoZXIgZWFzeSB0byBzd2l0Y2ggdGhlIGN1cnJlbnQgd3Jtc3IvcmRtc3IgcGFy
YXZpcnQgcGF0Y2hpbmcNCj4+IGxvY2F0aW9ucyB0byB1c2UgdGhlIHJkbXNyL3dybXNyIGlu
c3RydWN0aW9ucyBpbnN0ZWFkIG9mIGRvaW5nIGEgY2FsbCB0bw0KPj4gbmF0aXZlXyptc3Io
KS4NCj4gDQo+IFJpZ2h0LCBqdXN0IG1ha2UgdGhlIFhlbiBmdW5jdGlvbnMgYXNtIHN0dWJz
IHRoYXQgZXhwZWN0IHRoZSBpbnN0cnVjdGlvbg0KPiByZWdpc3RlcnMgaW5zdGVhZCBvZiBD
LWFiaSBhbmQgQUxUX05PVF9YRU4gdGhlIHRoaW5nLg0KPiANCj4gU2hvdWxkbid0IGJlIGhh
cmQgYXQgYWxsLg0KDQpDb3JyZWN0LiBBbmQgZm9yIHRoZSBuZXcgaW1tZWRpYXRlIGZvcm0g
d2UgY2FuIHVzZSBBTFRFUk5BVElWRV8zKCkuDQoNCg0KSnVlcmdlbg0K
--------------IalltgkvDsSESyH6wpAYJhIj
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------IalltgkvDsSESyH6wpAYJhIj--

--------------l43kLZ1qANrhEdych36notzD--

--------------07IxI3FeUVVif9J0hZIyhP9u
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmgLhVAFAwAAAAAACgkQsN6d1ii/Ey8e
vAf+KJOZqMUHxjnpltD/COFLiLrXAGHxc7ihiTnYIlmuJBNY2/PMbKPO2hF1JLAUEVIUZQrhNb3y
ixZojM1tK6ssy5bIFD/D8z9MibUFxp18Q5+vWLWuB5Bqiv4fZ0yZ3FN1PZEifNyTWix4R8inBi7B
oyP8CxQe7t9hRHp8vYhukpL9OwG4EAWiSNVS3r8/+D5xYtf2FhDGqTCLVm4VFuIPJfklOT4HzYhV
4dUaIcz2by4JTRko6sJmBmyAZ3prrPCusvfMG3AaPxRu7psLlgffSxlyyXRSwOdE7y48MVAqagjm
CHY32dOYjPAtQUadEKO+DN/Xv10wn72TiKJn+djfrw==
=xiTo
-----END PGP SIGNATURE-----

--------------07IxI3FeUVVif9J0hZIyhP9u--

