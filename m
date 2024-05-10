Return-Path: <linux-edac+bounces-1044-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B6F8C2B54
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 22:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E460A287CF3
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 20:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E2513848A;
	Fri, 10 May 2024 20:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FmidGq/q"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC0C137C5A;
	Fri, 10 May 2024 20:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715374451; cv=none; b=CKxb9nmMiYsaqxKnZqMiscyxC0iDfJIwOiIq46yE73OvH57FeqN/U7c1Br+ELjGPYbpAjtNX+Cn4dS42ONw01os9m6b8zS7ylSQCjo2xmqgaXi3/0ZMVmGPweF9vF4965MEVOscg/OtyEbTS/sFwsYp920k+omo2tbRh4N008eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715374451; c=relaxed/simple;
	bh=kv4KfnaKXK9z5kNW3ckxm9VTy+D5aMPSn3wwuinK2ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RGApbiRc14kBvmWIIGnaFibzfRJ6SZMKzZwPEQ6mleHxQycGMJqBPN7kwlti2kSpaHAkAjvR3keUgjAJebUpcLzFwv/ybfqLurgOs++FozuPiMW8WUPvxbigyJlKLJ/fwk0xT/mqVCsaksza9JzU+V0h/7FaflKhUkcjHP+t4H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FmidGq/q; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715374450; x=1746910450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kv4KfnaKXK9z5kNW3ckxm9VTy+D5aMPSn3wwuinK2ng=;
  b=FmidGq/qr7c6aadvRzSo05WcfU6BK4ULqBuAfZrKmymAK1RqL8IlA89q
   2eIksyJikDf7f1VRzUJvPbqouxu7FvtSR85DpxOhxb94O8THrq5La/u/Q
   p4/0AdMs9XtBOy5CSik0mlz0zfDKlJ4BtPXweDdJ28w9a79btDYhfcrPj
   E2ulY34zIxcFAVYgB3d5BINAudGZ1iPKXPO09Rrtrp8EnJA2SJQUOYOcP
   TPy87vnW40qPQ4fWKE/h8Lkx6jAWqGwS5fdpBNZuZpneRT2eCBJg4iDBY
   dDAUQD95Qia/W7esJjhH4RP7euLoGVoP0xNkcDA7Sp0cw9USGrRMtt7Ah
   w==;
X-CSE-ConnectionGUID: jDrmk3fsTDK/Qwnd5cWfqg==
X-CSE-MsgGUID: OXu0Xu8TQ3WU4TYI9SGRBA==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="11533603"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="11533603"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 13:54:09 -0700
X-CSE-ConnectionGUID: goZj2AC1SACb7BO1WbIkDA==
X-CSE-MsgGUID: IDMuEtAQTZyk6C3fdjzjYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="34264862"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.208])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 13:54:06 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>
Subject:
 Re: [RFC PATCH v2 3/3] ACPI: extlog: Make print_extlog_rcd() log
 unconditionally
Date: Fri, 10 May 2024 22:54:03 +0200
Message-ID: <2881368.Ex9A2HvPv6@fdefranc-mobl3>
In-Reply-To: <20240510192556.GDZj50xFIWSqK2gzQR@fat_crate.local>
References:
 <20240510112740.667445-1-fabio.m.de.francesco@linux.intel.com>
 <7009544.jJDZkT8p0M@fdefranc-mobl3>
 <20240510192556.GDZj50xFIWSqK2gzQR@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, May 10, 2024 9:25:56=E2=80=AFPM GMT+2 Borislav Petkov wrote:
> On Fri, May 10, 2024 at 09:00:34PM +0200, Fabio M. De Francesco wrote:
> > I thought that ELOG and GHES should be modeled consistently. ghes_proc()
> > prints to the console while ghes_do_proc() also uses ftrace.
>=20
> ghes_proc() calls ghes_do_proc(). I have no clue what you mean here.
>

My understanding is that ghes_proc() logs to the console and ghes_do_proc()=
=20
calls the tracers.=20

Therefore, GHES at the same time always reports the errors via two differen=
t=20
means.

Instead ELOG depends on the check on ras_userspace_consumers() to decide=20
whether to call print_extlog_rcd() to print the logs. And if it print to th=
e=20
kernel logs, it jumps to "out" and skips the tracers.

Why is it different with respect to how error reporting is made in GHES?=20

I thought that ELOG should be modeled similarly to GHES and so it should pr=
int=20
to the kernel logs always unconditionally and then it should also use ftrac=
e=20
(no goto "out" and skip tracers).

(1) Is my understanding of logging and tracing in ELOG and GHES correct?
(2) If it is, does it make sense for ELOG to print to the kernel log,=20
unconditionally, and then call the tracers like ghes_proc() + ghes_do_proc(=
)=20
do?

=46abio




