Return-Path: <linux-edac+bounces-5507-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4053FC7CE8B
	for <lists+linux-edac@lfdr.de>; Sat, 22 Nov 2025 12:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E004335424C
	for <lists+linux-edac@lfdr.de>; Sat, 22 Nov 2025 11:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F9B2F7AB5;
	Sat, 22 Nov 2025 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fFJl0DFF"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D131F37A1;
	Sat, 22 Nov 2025 11:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763811422; cv=none; b=pJCZmISewtPBNykUfkAZFD60YkFmtHPCsHMNtECyR2ZqdjVpf73EIr5vMEcdfYpWkFJJFeX6IkgCd25HfiRlHEmTSZJHxZuVUvHFSHW9p/pDWMYhPNUFiqW8es83KAoKvMLdxJdzHXz1VVpnuaaatCNVWCIS9tAriCeKHg+XDJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763811422; c=relaxed/simple;
	bh=3wFRhpyoBTISEUeWSI6RFRCI23Vl84wLgVvh+b7jTFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVj57IIlcdexDs5zBa4JF5Hu0mEBuV6xRnCwQtyghEV8e4BnuRBrskYcWMgh0ghr0suKBaNLGWBfTnq3a813UYIUwZwm0+ZwSUUFgEjJ8NoYNfIlkCCxjO/BCXZkLV6/wy5MI3XnlFRpLIeeGCL/dMqAEqNWRA5sTeJ0erOJ4I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fFJl0DFF; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7757740E00DE;
	Sat, 22 Nov 2025 11:36:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EDmPM0qPi4Xi; Sat, 22 Nov 2025 11:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763811410; bh=e+IxTgba59X5NTNporHArCj+R9MYjvwb1eYpYfEJANg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fFJl0DFFHsg6DZvn/4viW0HuYGGzFiOzYB7/+AIFk/mXPwii9u2fAXcp9zdmt5Pp2
	 DPFwfQ3DxgVkbE77xLLHYv27KNste/IjXAaN2rJpFQCu1AwjvwCg1qAgTB7u/BPkLd
	 6dvfTHjzxe8KeKwWIvnhqpoXR1pRNr1gTyoEbaaAWiORwyu3jmaaGNYl+Mvt6Pe+T1
	 pHM36QfQwwYyvR9NGuAHi5xAKFYNYoE1cjR36BVHII+boDAROXmzm/x/QxHvCo1qJk
	 YeS2EBmEQcmC9AT7qTvBR7aDF7whyw8sHg6MkhiJBukg5UzZRiEMCIkc/0O/C7MUcV
	 VT6MIY9XbUtUbMxMZnsWUT8AytDpfdAMGGl4KuruIMo/0kyslHENfUfa3On3OFATkQ
	 UHbJaYE8fIUQhZb3x4p9JDM8Vz25OicaY7VPkp6BooQjfOFrVuNxedEs5jKsT5B7Ff
	 /F988/7Qn94VRaD8Sh/eKgnbDIxlTTfiIYEwS7lpxdEJGXtHGZkGOGWdvKWCJoXc3p
	 TcILRx2ySw9SxsKZ7vpdzPq3GYLnGlbvERvhaM2CqdEm8dhtK6CqNd6IKx9EZ9zcDJ
	 9voDxWnj0vSGPwyhAwis8qezutGum9CDEhE2ZhF72E2qqyp+KD6RME8bCl4flWXy3C
	 Iu0iMJYLk2Zrqo8BUoIqdmrY=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 2E9A440E015A;
	Sat, 22 Nov 2025 11:36:14 +0000 (UTC)
Date: Sat, 22 Nov 2025 12:36:12 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: Daniel Ferguson <danielf@os.amperecomputing.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"rppt@kernel.org" <rppt@kernel.org>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	Linuxarm <linuxarm@huawei.com>,
	"rientjes@google.com" <rientjes@google.com>,
	"jiaqiyan@google.com" <jiaqiyan@google.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>,
	"somasundaram.a@hpe.com" <somasundaram.a@hpe.com>,
	"erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>,
	"duenwen@google.com" <duenwen@google.com>,
	"gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>,
	"Zengtao (B)" <prime.zeng@hisilicon.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>,
	wanghuiqiang <wanghuiqiang@huawei.com>
Subject: Re: [PATCH v12 1/2] ACPI:RAS2: Add ACPI RAS2 driver
Message-ID: <20251122113612.GAaSGgLOTZHWXQgpzY@fat_crate.local>
References: <20250912141155.GAaMQqK4vS8zHd1z4_@fat_crate.local>
 <9433067c142b45d583eb96587b929878@huawei.com>
 <20250917162253.GCaMrgXYXq2T4hFI0w@fat_crate.local>
 <20250917183608.000038c4@huawei.com>
 <20250919103950.GCaM0y9r6R6b5jfx8z@fat_crate.local>
 <6ac4ad35975142df986bfcb27d1e9b2c@huawei.com>
 <20251015223242.GBaPAhCuS7YWqu-aH0@fat_crate.local>
 <75e9bae2d30748d5b66c288135915cc3@huawei.com>
 <20251103131914.GEaQir0sdz4Te_ea0l@fat_crate.local>
 <409217e466a9497697a82e2ac8a6a5f7@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <409217e466a9497697a82e2ac8a6a5f7@huawei.com>

On Tue, Nov 04, 2025 at 12:55:48PM +0000, Shiju Jose wrote:
> Thanks Borislav for the valuable suggestion and it make sense. Since
> presently we are not sure how reaching the end of the node work on
> individual platforms,  can we do this as an optimization in the next stage?
> and Can we start with basic demand scrubbing without address range control
> in sysfs, but with user space set only scrub rate and enable_demand, kernel
> set the node's addr range as Requested Address Range to start the demand
> scrubbing on entire node, as you suggested?

Yap, I like starting simple and then delving into a more involved solution
which is dictated by real life.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

