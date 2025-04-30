Return-Path: <linux-edac+bounces-3794-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C771DAA46B8
	for <lists+linux-edac@lfdr.de>; Wed, 30 Apr 2025 11:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF51B3A938C
	for <lists+linux-edac@lfdr.de>; Wed, 30 Apr 2025 09:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45F8223327;
	Wed, 30 Apr 2025 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="AB7yHzHZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFEC222563;
	Wed, 30 Apr 2025 09:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746004400; cv=none; b=gI1YKG0OrWg59wWn1OEURo4jueaBSTrLdPw9lOTTZl9yEE0MFKohuLUaUTahRGngc76o1Hk4+RuvGKnGlqVjv7VWMP3/7QT32rXDZTIgZ7s/znWeVsdQ1TlPwsWFiy4JukO8G0Lag/5KPfZbkj7TI3SrMnmTmM5svexlTDnUgiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746004400; c=relaxed/simple;
	bh=d2DDZC70gbpscPgbWYbwQPfzHaJwMRuO8UuuTeGXlnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIhv4hR7OcNBRJuQz4A+VJMW3ST7lKZ/P5Q/Wpt5Th8ePBkZyXWhZ/elRvpU0glPDoSUm11Wo9qkUchz3gUcvkeE6fMmHLjUyLgIYG+eLCL4Nx0XOGtTaTfOEOQgFf+IH5ocqrrUMPRzNsUIcAiOwk0CWmsTiCECJuCDLmkJBGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=AB7yHzHZ; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 53U9CK8G823665
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 30 Apr 2025 02:12:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 53U9CK8G823665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1746004344;
	bh=/7rTi9HvZ6onJSTdYqzzgTETKP8TAGe+/d/qRha+9aU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AB7yHzHZAPzuuD3gLAO5sc0iXVQ+0GQF0XcAMrHLP5xDswXkqmewyho4mFI+++jqF
	 MUjpki2/cVxD8OLc2l7OexLkzHfkljDGVxdNMg55yJJaHHq61lYWVxCqkbcDlKPQUA
	 zSYweN1JtJ7V8wjKay/kfLYDENnpupYxIHInm8F/XdaI7EVCrqyb+ID3uZvWWl1lZ6
	 JjsGcIx5lBkgRJaxum2F+bKJHQvcOpilyvKrFHCwoCu7yRPQ3Cx+lli3hqR1yJzAxL
	 76HNJqHr0UMhGU5BXc72W6NjFJ4FPu6zOuAmJG9uLPuSgV47tgyG8sly9PeO8s0Rh4
	 x5a/U6REmH0ZA==
Message-ID: <d5b7edab-1872-45ff-8f2e-bcb34f6bdc23@zytor.com>
Date: Wed, 30 Apr 2025 02:12:19 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/15] x86/msr: Add missing includes of <asm/msr.h>
To: Michael Kelley <mhklinux@outlook.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "ajay.kaher@broadcom.com" <ajay.kaher@broadcom.com>,
        "bcm-kernel-feedback-list@broadcom.com"
 <bcm-kernel-feedback-list@broadcom.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "luto@kernel.org"
 <luto@kernel.org>,
        "boris.ostrovsky@oracle.com"
 <boris.ostrovsky@oracle.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "decui@microsoft.com" <decui@microsoft.com>,
        "dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>
References: <20250427092027.1598740-1-xin@zytor.com>
 <20250427092027.1598740-2-xin@zytor.com>
 <a1917b37-e41e-d303-749b-4007cda01605@linux.intel.com>
 <SN6PR02MB4157EA2E3B827141588DA310D4832@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 xsDNBGUPz1cBDACS/9yOJGojBFPxFt0OfTWuMl0uSgpwk37uRrFPTTLw4BaxhlFL0bjs6q+0
 2OfG34R+a0ZCuj5c9vggUMoOLdDyA7yPVAJU0OX6lqpg6z/kyQg3t4jvajG6aCgwSDx5Kzg5
 Rj3AXl8k2wb0jdqRB4RvaOPFiHNGgXCs5Pkux/qr0laeFIpzMKMootGa4kfURgPhRzUaM1vy
 bsMsL8vpJtGUmitrSqe5dVNBH00whLtPFM7IbzKURPUOkRRiusFAsw0a1ztCgoFczq6VfAVu
 raTye0L/VXwZd+aGi401V2tLsAHxxckRi9p3mc0jExPc60joK+aZPy6amwSCy5kAJ/AboYtY
 VmKIGKx1yx8POy6m+1lZ8C0q9b8eJ8kWPAR78PgT37FQWKYS1uAroG2wLdK7FiIEpPhCD+zH
 wlslo2ETbdKjrLIPNehQCOWrT32k8vFNEMLP5G/mmjfNj5sEf3IOKgMTMVl9AFjsINLHcxEQ
 6T8nGbX/n3msP6A36FDfdSEAEQEAAc0WWGluIExpIDx4aW5Aenl0b3IuY29tPsLBDQQTAQgA
 NxYhBIUq/WFSDTiOvUIqv2u9DlcdrjdRBQJlD89XBQkFo5qAAhsDBAsJCAcFFQgJCgsFFgID
 AQAACgkQa70OVx2uN1HUpgv/cM2fsFCQodLArMTX5nt9yqAWgA5t1srri6EgS8W3F+3Kitge
 tYTBKu6j5BXuXaX3vyfCm+zajDJN77JHuYnpcKKr13VcZi1Swv6Jx1u0II8DOmoDYLb1Q2ZW
 v83W55fOWJ2g72x/UjVJBQ0sVjAngazU3ckc0TeNQlkcpSVGa/qBIHLfZraWtdrNAQT4A1fa
 sWGuJrChBFhtKbYXbUCu9AoYmmbQnsx2EWoJy3h7OjtfFapJbPZql+no5AJ3Mk9eE5oWyLH+
 QWqtOeJM7kKvn/dBudokFSNhDUw06e7EoVPSJyUIMbYtUO7g2+Atu44G/EPP0yV0J4lRO6EA
 wYRXff7+I1jIWEHpj5EFVYO6SmBg7zF2illHEW31JAPtdDLDHYcZDfS41caEKOQIPsdzQkaQ
 oW2hchcjcMPAfyhhRzUpVHLPxLCetP8vrVhTvnaZUo0xaVYb3+wjP+D5j/3+hwblu2agPsaE
 vgVbZ8Fx3TUxUPCAdr/p73DGg57oHjgezsDNBGUPz1gBDAD4Mg7hMFRQqlzotcNSxatlAQNL
 MadLfUTFz8wUUa21LPLrHBkUwm8RujehJrzcVbPYwPXIO0uyL/F///CogMNx7Iwo6by43KOy
 g89wVFhyy237EY76j1lVfLzcMYmjBoTH95fJC/lVb5Whxil6KjSN/R/y3jfG1dPXfwAuZ/4N
 cMoOslWkfZKJeEut5aZTRepKKF54T5r49H9F7OFLyxrC/uI9UDttWqMxcWyCkHh0v1Di8176
 jjYRNTrGEfYfGxSp+3jYL3PoNceIMkqM9haXjjGl0W1B4BidK1LVYBNov0rTEzyr0a1riUrp
 Qk+6z/LHxCM9lFFXnqH7KWeToTOPQebD2B/Ah5CZlft41i8L6LOF/LCuDBuYlu/fI2nuCc8d
 m4wwtkou1Y/kIwbEsE/6RQwRXUZhzO6llfoN96Fczr/RwvPIK5SVMixqWq4QGFAyK0m/1ap4
 bhIRrdCLVQcgU4glo17vqfEaRcTW5SgX+pGs4KIPPBE5J/ABD6pBnUUAEQEAAcLA/AQYAQgA
 JhYhBIUq/WFSDTiOvUIqv2u9DlcdrjdRBQJlD89ZBQkFo5qAAhsMAAoJEGu9DlcdrjdR4C0L
 /RcjolEjoZW8VsyxWtXazQPnaRvzZ4vhmGOsCPr2BPtMlSwDzTlri8BBG1/3t/DNK4JLuwEj
 OAIE3fkkm+UG4Kjud6aNeraDI52DRVCSx6xff3bjmJsJJMb12mWglN6LjdF6K+PE+OTJUh2F
 dOhslN5C2kgl0dvUuevwMgQF3IljLmi/6APKYJHjkJpu1E6luZec/lRbetHuNFtbh3xgFIJx
 2RpgVDP4xB3f8r0I+y6ua+p7fgOjDLyoFjubRGed0Be45JJQEn7A3CSb6Xu7NYobnxfkwAGZ
 Q81a2XtvNS7Aj6NWVoOQB5KbM4yosO5+Me1V1SkX2jlnn26JPEvbV3KRFcwV5RnDxm4OQTSk
 PYbAkjBbm+tuJ/Sm+5Yp5T/BnKz21FoCS8uvTiziHj2H7Cuekn6F8EYhegONm+RVg3vikOpn
 gao85i4HwQTK9/D1wgJIQkdwWXVMZ6q/OALaBp82vQ2U9sjTyFXgDjglgh00VRAHP7u1Rcu4
 l75w1xInsg==
In-Reply-To: <SN6PR02MB4157EA2E3B827141588DA310D4832@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/29/2025 9:20 PM, Michael Kelley wrote:
>> Also under hyperv/ not all files are covered but I'm a bit hesitant to
>> suggest a change there since I'm not sure if they (hypervisors) do
>> something special w.r.t. msr.
> I've worked on the Hyper-V code in Linux for 8 years or so, first as
> a Microsoft employee, and more recently as a retiree. 🙂 I'm not
> aware of anything special w.r.t. MSR access for Hyper-V guests.
> All the normal Linux code for accessing MSRs just works. Hyper-V
> *does* provide a set of synthetic MSRs that are unique to
> Hyper-V, but they are also accessed using normal Linux code. Of
> course, at runtime the access to these synthetic MSRs always
> traps to the hypervisor.
> 
> I'm planning to apply Xin Li's patch set and make sure nothing
> breaks for Hyper-V guests, and particularly when running as an
> SEV-SNP or TDX guest. Hopefully I can do that by early next week
> at the latest.

Hi Michael, I appreciate it!

