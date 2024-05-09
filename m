Return-Path: <linux-edac+bounces-1025-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7478C173C
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2024 22:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E3A1C21DD8
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2024 20:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D478F14C5AF;
	Thu,  9 May 2024 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EdbGzmPW"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534A3129E86;
	Thu,  9 May 2024 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285048; cv=none; b=nmxdxCeLjrGBdGrNoDMeUNUbEobbe2jyFMgIUrhRMUYjLE/m0knETxk0p5mr6DySPHzCJO4f7MYx73MYPXKERC3zHPJjELBch6CVw+VaXPjUFWeUoDyDWkOBwJSwMXOBPPDwQbjx6Bp/qibpc5o14f9FW/ShUrn+kivXRvrWDKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285048; c=relaxed/simple;
	bh=pxGd4CDP41NclFRXMdY20h/Qs6nREZrAp6NTkT2Uv7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EN6Uw12v3erEj9MZTu42J4aTryrWpJuamyayVdVZ94VUnxvF/mHkjrsv7k8IKT52hdtIM742rShpNNQP8By1vlFiTiNXCdLYLcQeyUwOc+SKmmMXkILPH920Gau7CDnYR3KTCQmotBlZtbeOp7ImoT0/dAITKQeflPS2y/8Q4LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=EdbGzmPW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2383C40E024D;
	Thu,  9 May 2024 20:04:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id A2zAiRG3Y64e; Thu,  9 May 2024 20:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715285039; bh=hTxyMbW2JqF7oP0XGaZ6IM3jMn36gRHXPNQMDzL/rlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EdbGzmPWCDxbDlP5o2UbdaxZLhzj6Nqr8fbkFRCtQrLqH1wLYuXYQ7H6KJvdguKbD
	 LQOkmBBKv3kVyIYOm+lBFqFfEIR8ClWe37eivEmyWCE12wB5UulxQ0qSBcMkS5XM64
	 a4JggIPXNmrdZMWXvBTF19mUGyf67zJRTli/VY6OCU5htm5jh8jouPYCklLGvp1LaV
	 mHxhO5BV/bEYqZFcbsdWOuWWiP31PcNg6HCv/TKCMMvaMLm0vleYB/JOtxOG6DTJEb
	 yri9poMX/YwXG5AH/Cnro5m3Vp2FB/a+D4hQmVhQuZ0ffiUvbahAhrUAq0DuuU6oE6
	 pXKAIcMttmKUrDMN47lno4ZTeU+DY3kRgzD3Riwhos1o58MyNcQ3AVsguPQmD2sjMp
	 RAG8UDIweLAzM4G0P62VSWvXaJpAImHHMi8qCEiOJQ4VIg7qgVS8uXdkn73JoYN40H
	 X8tqQIFeYEqnCWvOPRtGh1BnHjRO0SiOvoAOg7niSj5lGZpMSDrEPcs5dutbD7f2CQ
	 CYDArNPhZCqFjtu8GUBRIcHLBjFzeXRvAnXsAWpa9s8B/2C8PRyZCLZ0nmC+dVAeDg
	 0LyOCWhwm89Qyg6PH923mA0yyekwqjlxOghpP8E4cQqLp06WlRJMQlkwjSKAUg7c1z
	 UizAsoNJPKZ2Z0FI+jqWOnWw=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1242840E0249;
	Thu,  9 May 2024 20:03:13 +0000 (UTC)
Date: Thu, 9 May 2024 22:03:06 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Shiju Jose <shiju.jose@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>,
	"leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"rientjes@google.com" <rientjes@google.com>,
	"jiaqiyan@google.com" <jiaqiyan@google.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>,
	"somasundaram.a@hpe.com" <somasundaram.a@hpe.com>,
	"erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>,
	"duenwen@google.com" <duenwen@google.com>,
	"mike.malvestuto@intel.com" <mike.malvestuto@intel.com>,
	"gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>,
	"Zengtao (B)" <prime.zeng@hisilicon.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>,
	wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH v8 01/10] ras: scrub: Add scrub subsystem
Message-ID: <20240509200306.GAZj0r-h5Tnc0ecIOz@fat_crate.local>
References: <20240419164720.1765-2-shiju.jose@huawei.com>
 <20240425101542.GAZiotThrq7bOE9Ieb@fat_crate.local>
 <63fdbe26b51f4b7c859bfb30287c8673@huawei.com>
 <20240506103014.GHZjixNhhFkgkMhDg_@fat_crate.local>
 <e0ce36eb80054440ab877ccee4e606de@huawei.com>
 <20240508172002.GGZju0QvNfjB7Xm6qL@fat_crate.local>
 <4ceb38897d854cc095fca1220d49a4d2@huawei.com>
 <20240508192546.GHZjvRuvtu0XSJbkmz@fat_crate.local>
 <20240509101939.0000263a@Huawei.com>
 <D9511DC1-1566-473A-A426-111BB1F7F9F0@alien8.de>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D9511DC1-1566-473A-A426-111BB1F7F9F0@alien8.de>

On Thu, May 09, 2024 at 05:52:18PM +0200, Borislav Petkov wrote:
> Are you arguing for the nonsensical "it should load" case because it
> is simply easier this way? How hard is that "jump through hoops" thing
> anyway?

Let's see: the following patches add something called
GET_SUPPORTED_FEATURES which is used to detect whether the system has
patrol scrub functionality etc.

Then there's ras2_acpi_init() which checks for a RAS2 ACPI table.

Are you saying that checking for those two things in the init function
is jumping through hoops?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

