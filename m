Return-Path: <linux-edac+bounces-1042-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBAC8C2A25
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 21:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB00D1F23317
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 19:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD6144375;
	Fri, 10 May 2024 19:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RhDibBVA"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AA71D530;
	Fri, 10 May 2024 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715367657; cv=none; b=dz5qQlRuz1i/EJF2e+BItw13bS43s8GM8/PLJyuFyo68ZocMkxcpGRB+UG48fag4q25e1NUIQphd4z/8wn5lbGfzectrLVQcAnVtYn2YORYvYrlkzWOqB3e+gjql1J/px1Taq3eIShTL/cUabrwHMB/mGNFGainHnxwzT4frkx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715367657; c=relaxed/simple;
	bh=s6ILEciIW26eOwuIRXGs/El6boV8M8kmhjL1g78NP5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kl/yemxnN1kNYUdz8c24wJImJY24Mo+frZacIv9lPWUtjnCXwklYaRDCKk5y8EoUrxAEfKGLxQ/nDYJJ6qvUrLAIM6VunTuegaydb95z7K/oMxO7KP6ahSH7MDsf6JWcsL3mTUVraF3XFIjrRfZIaWAzGBZslwADo0GdHhggFvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RhDibBVA; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715367641; x=1746903641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s6ILEciIW26eOwuIRXGs/El6boV8M8kmhjL1g78NP5Y=;
  b=RhDibBVAbioEKD2w4jNJugXmVXuTXVhuqK7//KqE8oK0JZpItt3AVP+8
   UxmpTdNyK7cEhyoERddhGLO9n+wlatMjKKSZWB6TtnIyWqYL5bULZXwCn
   8RYp90jPLq8DC059SZULRPArky8SaisMr/9eu1Wbcme8OxdZJrJVTbIGS
   dyNXA/P8TxU9AtlbTv5EofiubMNq+XQvwB2ArZ/Ys44MId1+bJei5lPJl
   2fqnyIqwIZn1MJj2QCL6F7ga4BwoLfaeMgkbI9tnZ9ypbdBUQD2aVW6cz
   8AfNQfY7Jmh8+sclz2m4ekG4E9M8qkVnjd8Jvm69tO7qGnvc/rxaeWqOP
   w==;
X-CSE-ConnectionGUID: bsHmoWZcSyyahwBUX+v1JA==
X-CSE-MsgGUID: NBczbAh1SJut/sj5twODzg==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="36742681"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="36742681"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 12:00:41 -0700
X-CSE-ConnectionGUID: xvcr9McrQYOjlNzYC7TPfQ==
X-CSE-MsgGUID: n8D6LLd2QJKk7lGohA/VyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="34139624"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.205])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 12:00:38 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>
Subject:
 Re: [RFC PATCH v2 3/3] ACPI: extlog: Make print_extlog_rcd() log
 unconditionally
Date: Fri, 10 May 2024 21:00:34 +0200
Message-ID: <7009544.jJDZkT8p0M@fdefranc-mobl3>
In-Reply-To: <20240510125214.GCZj4YfluoP-mDz3_U@fat_crate.local>
References:
 <20240510112740.667445-1-fabio.m.de.francesco@linux.intel.com>
 <20240510112740.667445-4-fabio.m.de.francesco@linux.intel.com>
 <20240510125214.GCZj4YfluoP-mDz3_U@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, May 10, 2024 2:52:14=E2=80=AFPM GMT+2 Borislav Petkov wrote:
> On Fri, May 10, 2024 at 01:21:47PM +0200, Fabio M. De Francesco wrote:
> > Make extlog_print_rcd() log unconditionally to report errors even if
> > userspace is not consuming trace events. Remove ras_userspace_consumers=
()
> > because it is not anymore used.
>=20
> Did you do any git archeology before that?
>=20
> d6cae935ec5b ("trace, eMCA: Add a knob to adjust where to save event log")
>=20
> I can't find in this commit message why this is needed... Do share pls.=20
>=20
> > This change makes extlog_print() (ELOG) log consistently with ghes_proc=
()
> > (GHES).

I thought that ELOG and GHES should be modeled consistently. ghes_proc()=20
prints to the console while ghes_do_proc() also uses ftrace. I made this sh=
ort=20
series an RFC mainly to ask / receive comments on this change (3/3).

If we want to make ELOG and GHES act similarly, this patch is needed.=20
Otherwise, things should be left the way they currently are.=20

I'll make a v3  with a more clear explanation of why I think we should pref=
er=20
to make ELOG act similarly to GHES in how kernel logs are handled.

> Avoid having "This patch" or "This commit" in the commit message. It is
> tautologically useless.
>
> Also, do
>=20
> $ git grep 'This patch' Documentation/process
>=20
> for more details.
>=20
> Pls have a look at our documentation and check all your patches.
>=20
> Thx.

Please note that I was introducing the "why" part of the message. I never=20
refer to this patch for the "what", and I always use an imperative tone onl=
y=20
in the "what" part.=20

However, I see why this commit message was poor. And probably also the othe=
r=20
two were low quality. Therefore, I'll rework this and also the other two=20
messages.

Thanks for your comments,

=46abio




