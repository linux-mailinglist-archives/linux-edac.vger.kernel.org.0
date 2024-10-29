Return-Path: <linux-edac+bounces-2332-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F2B9B5315
	for <lists+linux-edac@lfdr.de>; Tue, 29 Oct 2024 21:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1FE81C22A68
	for <lists+linux-edac@lfdr.de>; Tue, 29 Oct 2024 20:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06AB2076A7;
	Tue, 29 Oct 2024 20:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RkLGKsPD"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEE71940B3;
	Tue, 29 Oct 2024 20:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730232532; cv=none; b=kHMGGNe23KGyEtkWWkQsJkkeJ6hTe1Jazi3A5NblUacsDrWlKYfKX830VpYdjhCjoDcpTBLvA594TuD9NFgXCR7DYDyuLVtkCkCGyZ7fHHxCL/UDjvsmhu+S7uFf1SMgv6Iv3+JMYjzDV0tv4jyYYvvu6peauaH0lSoaq28Gzqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730232532; c=relaxed/simple;
	bh=/go7D6iiPFhjooAcsuQcULBhWE+LPR/eVt4II2S/dbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7TTaN3ot64qzgEKIF92xp1SxE3K08Y21PsdIcU3pS1UwLYmW7VhbZ0DLSnXjJQ5MD67WJFZEZFA+KNoeYQB+0MatIpHlrUcJRQrAEC59ekQ6PcmhEu37YavL3aha52cZiNUdXUDA64dq11u7FRQrxEpfXdNxsIz1N+x+L2S2l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RkLGKsPD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3E30440E019C;
	Tue, 29 Oct 2024 20:08:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9fsc2ouLds1v; Tue, 29 Oct 2024 20:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730232522; bh=XOaXIhOTLxxAUJajaKBJHWLhdxELxOiOp7rGu1CXQQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RkLGKsPDEsEkctjG4P57EtfNYk62T6zZX+Rk3qdkFzK0W7XsnXDymbpS56RiayrQK
	 q1wS6R8xSQfFnaAOOiigbNJWIYvhosJz8hWhkF3G0F/qY2PbsRN0N+OXlT6hLB0gpf
	 k24pYMT2ldLpvZlNnM4K9n2RzeBvKCI+XfKL7KTjvLjt1dIRC+ft7SU+HcMmbgcXYM
	 /mfG+lAs6mG65LWqvU9pphgVohi8AY3XIjHFBVULlyIWDfO3rlzkk0K4MmqlnhamKD
	 K8Tj4dNzKBfIFSiv6Jakt6/8UNrG2KZQp1z2KNROV9teaYLS2Pr1zowEUbnN9UXiBG
	 4aCookDmfXn/XXQ3EuISdR2TrNhOZUs48D7rWNa7ocCyHXcJTihgodpCjlOyVuauev
	 UUh/1GRW1VYCBiLwTgeQBdBtQ/VpYg+3jQ2zpCHDJ6AV+EGm6Z7lvSArIHbmWaXcE0
	 CyfK+QC15kGl+ZjpbUth5QeZrQfIaOjhNLP1gnwkf+yd7zrvN9MBZzeqFQ2/8AzWR0
	 zk6w9Lm77XqFn1kJv4hKzRmvLjfN+jrxNMb6ldBdmFaS8S6V0RefsJ2F2TW9802hf1
	 sYWGR+mrBmI2I7vysm3GrN+bcBnFr1inWDCdZwP+NCu2gzBVvsXIfFm+Ca2yKqoMbY
	 5xla9TIrHlknS4fL/lCb3WL4=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5A7B640E015E;
	Tue, 29 Oct 2024 20:07:55 +0000 (UTC)
Date: Tue, 29 Oct 2024 21:07:49 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>,
	"leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
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
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>,
	"Zengtao (B)" <prime.zeng@hisilicon.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>,
	wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v14 03/14] EDAC: Add ECS control feature
Message-ID: <20241029200749.GSZyFAlS0cdnMbTPVL@fat_crate.local>
References: <20241025171356.1377-1-shiju.jose@huawei.com>
 <20241025171356.1377-4-shiju.jose@huawei.com>
 <20241028111637.GSZx9yleFPOjTklIVr@fat_crate.local>
 <2263e5a551e24a6ca63dbe33538a5ce8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2263e5a551e24a6ca63dbe33538a5ce8@huawei.com>

On Mon, Oct 28, 2024 at 04:03:31PM +0000, Shiju Jose wrote:
> I will update to 0 and 1. 

Yes please. Just because some spec is written by hw people, doesn't mean we
should use this braindead format.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

