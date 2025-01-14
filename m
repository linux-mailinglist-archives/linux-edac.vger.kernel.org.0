Return-Path: <linux-edac+bounces-2890-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAFAA10587
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 12:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 128037A1EC5
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 11:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B20B234D01;
	Tue, 14 Jan 2025 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxarYMfK"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309F8234CF5;
	Tue, 14 Jan 2025 11:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736854394; cv=none; b=bSKAAb05KY3J1TNo0IUgvi/aNqEF76CjcaVNbTgRboX7IyUb4NCauRAK3WTpoFj+QU3WnT6rst+LeZzPoBlhF/InZPW6s2FPJPGotenFihBXTIVimCwIYZduhyEH5vUhWp/pVBM7697lNyhHUGc4O+tl5LumDvCPHotUgPXuKaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736854394; c=relaxed/simple;
	bh=MrivJ/DDz0XYxvN0xXP9ngJ9hdTIa0KM7xnuiQfKegw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCRyXlmkrukydbvJfwkopXO0ERaJqIuZS+USqWk4f8oMZ3NccEydagSYDLRxaLtW8EZvnicpaTcBRDEJGzVFwZAsBi4vNX1tJonNDhetXuSpWqPYi8732H1AMo5eid2K1gZkkNE03Zs+KL2FeJsHmYYb8Jel9TtHH2fm3zEmO8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxarYMfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC21C4CEDD;
	Tue, 14 Jan 2025 11:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736854393;
	bh=MrivJ/DDz0XYxvN0xXP9ngJ9hdTIa0KM7xnuiQfKegw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SxarYMfKtM3whO3COpRgQ5tRlIqHXwhCJef8sfGkc1XBI9pmZAZPc/Yv5v2vPz/wg
	 lanuPJZ7Fe6hHQDXey/rhsOodTJbEiKFI6HEoph4CExODchImkWyDBEI0GWb03+7eW
	 3CyQWJkYA/gZKmtSYM5Jl+Z9fFzAQjCa4IHCSKtkowRrKKihPa9bgnK0CfUo9+xqiA
	 Aa3ISK7qRCWly58IA6Xj5vSfRsukGPpDAgRZDRTPfu+pxFtOkbVApc1TQCHVJDs24r
	 es3fPrRbCks8C+wcHvA78bFYSPdCt+0VNkFkazcoOmXfaWXzc7TIeU2Uo4FxzKbAX7
	 ZUkYTDpWXO7Sg==
Date: Tue, 14 Jan 2025 12:33:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
 "tony.luck@intel.com" <tony.luck@intel.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
 "mchehab@kernel.org" <mchehab@kernel.org>, "dan.j.williams@intel.com"
 <dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
 "Jonathan Cameron" <jonathan.cameron@huawei.com>, "dave.jiang@intel.com"
 <dave.jiang@intel.com>, "alison.schofield@intel.com"
 <alison.schofield@intel.com>, "vishal.l.verma@intel.com"
 <vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
 <Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
 "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
 <rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
 "Jon.Grimm@amd.com" <Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "naoya.horiguchi@nec.com"
 <naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
 "jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
 <somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
 "pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
 <duenwen@google.com>, "gthelen@google.com" <gthelen@google.com>,
 "wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
 "dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
 "wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
 "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
 <tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
 <kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
 Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v18 01/19] EDAC: Add support for EDAC device features
 control
Message-ID: <20250114123301.3665ada8@foz.lan>
In-Reply-To: <08f67030bb81401688ef8a5505f10c7e@huawei.com>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
	<20250106121017.1620-2-shiju.jose@huawei.com>
	<20250113160611.39bdf3b3@foz.lan>
	<08f67030bb81401688ef8a5505f10c7e@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 14 Jan 2025 10:08:42 +0000
Shiju Jose <shiju.jose@huawei.com> escreveu:

> >> diff --git a/Documentation/edac/features.rst
> >> b/Documentation/edac/features.rst new file mode 100644 index
> >> 000000000000..f32f259ce04d
> >> --- /dev/null
> >> +++ b/Documentation/edac/features.rst
> >> @@ -0,0 +1,94 @@
> >> +.. SPDX-License-Identifier: GPL-2.0  
> >
> >SPDX should match what's written there, e. g.
> >
> >	.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.2-no-invariants-or-later
> >
> >Please notice that GNU FDL family contains both open source and non-open
> >source licenses. The open-source one is this:
> >
> >	https://spdx.org/licenses/GFDL-1.2-no-invariants-or-later.html
> >
> >E.g. it is a the license permits changing the entire document in the future, as
> >there's no invariant parts on it.  
> This seems not widely used, have seen this is used in few documents only. 

This was added after some discussions I had with LF people in charge
of SPDX: GFDL explicitly allows to have some parts that can't be touched
by future patches. Those are "invariant" parts of the document.

They were designed in a way that the original author's notes
can't be touched on any further patch from someone's else. 

You can see more about that at:

	https://www.gnu.org/licenses/fdl-howto-opt.en.html

See:

	"The classical example of an invariant nontechnical section in a free manual
	 is the GNU Manifesto, which is included in the GNU Emacs Manual. The GNU
	 Manifesto says nothing about how to edit with Emacs, but it explains the
	 reason why I wrote GNU Emacs"

And:
	https://www.gnu.org/gnu/manifesto.html

Due to its nature of being invariant, most people consider it as a
non-open-source license. See, for instance:

	https://www.debian.org/vote/2006/vote_001

Due to such concerns, after several discussions I had with interested parties,
this was added to SPDX spec and to the Linux Kernel:

	- GFDL-1.2-no-invariants-only - for GFDL v 1.2 only
	- GFDL-1.2-no-invariants-or-later - for GFDL v 1.2 or later

(plus variants for other GFDL versions)

You may use either one of them, but you should *not* use GFDL-1.2
as this is deprecated:

	https://spdx.org/licenses/GFDL-1.2.html

And need to be replaced by either:

	https://spdx.org/licenses/GFDL-1.2-no-invariants-or-later.html
or:
	https://spdx.org/licenses/GFDL-1.2-invariants-only.html

Thanks,
Mauro

