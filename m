Return-Path: <linux-edac+bounces-5537-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617BAC8AA1A
	for <lists+linux-edac@lfdr.de>; Wed, 26 Nov 2025 16:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93E93AF276
	for <lists+linux-edac@lfdr.de>; Wed, 26 Nov 2025 15:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103573321CE;
	Wed, 26 Nov 2025 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgSXAXr/"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA7B3321BE;
	Wed, 26 Nov 2025 15:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764170818; cv=none; b=Cg5hVH2ma2ODEBq8vgnfa9JcB9GxuNpmeYqw1DSdNeMQZqMxAqtAVDB/ZUQ4wmMWrktHlE9/w/YV8fD3tHbmN8WRkAi57699ulqdIYVflqZdmgGbHkjRvaDOZsDGXb1xZIQhMJn8OsXvmLBoRAtojAx0cowvSlkxkXVKVNThc/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764170818; c=relaxed/simple;
	bh=QAC3fobOvEOkVyyczfHVZmAC5/GWc+q0JGJfmAQ2DVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrzpbH7wyG+hyll9hrpHnyZRf1zedvtkc5Lmr/04RQTf9PzoMtCIKmWffr56M6n9jzUjM3Zgr+Jko9c1fdsqG3/qSPIjFA1qvpHSE+h519fsVBIXmwRICWys/rycdB8kwhFgERSyJHHuAgy+W3Nm/HTUn8hsbkef3W0L3Ycr2+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgSXAXr/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F542C4CEF7;
	Wed, 26 Nov 2025 15:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764170818;
	bh=QAC3fobOvEOkVyyczfHVZmAC5/GWc+q0JGJfmAQ2DVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pgSXAXr/oa/yzjpn65BaARI+gZXAE2Lw1kk+dW1iDuK6mLYdfZN2tma2Azum5M2Qx
	 QFcHuJiRq/dD6jadNMUirqcieJih0W0+rWj7zaC4Yg/I8AOF7Ww4OoC5+Q6KesKPp3
	 V6rDVyeJ1+fdz1nu2ZB4/2dvTdhloCBKkpkD0c6pJ15jVxPQWL+eLDJJcS++z+NumB
	 inTQMEghghpb0VStOevQYhUCkKAVjJ8UeLG40BzG6hW/OJVwfXcObmbe5GbsaTsi3Z
	 yDrpN4QxPqq39cjZlltadkx1xaHBYjOVhQ/qhYLGrfqYdoYFAs95OVVUe4LWNd64kx
	 3AWuzutikTE4A==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vOHQ0-00000003oyK-2rsn;
	Wed, 26 Nov 2025 16:26:56 +0100
Date: Wed, 26 Nov 2025 16:26:56 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Ira Weiny <ira.weiny@intel.com>, Jason Tian <jason@os.amperecomputing.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Len Brown <lenb@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
	Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] apei/ghes: don't go past allocated memory
Message-ID: <mn45f66kdydxqugsdzln2j7sqs6g5o2iwo4hd6l3klbiavidon@53ergacbysko>
References: <cover.1764169337.git.mchehab+huawei@kernel.org>
 <3f6764ddbc0b596a43a73616d972c2ba0060d1b1.1764169337.git.mchehab+huawei@kernel.org>
 <20251126151325.GCaScZFXvm-7PYy0Dh@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126151325.GCaScZFXvm-7PYy0Dh@fat_crate.local>
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

On Wed, Nov 26, 2025 at 04:13:25PM +0100, Borislav Petkov wrote:
> On Wed, Nov 26, 2025 at 04:05:46PM +0100, Mauro Carvalho Chehab wrote:
> > If the BIOS generates a very small ARM Processor Error, or
> > an incomplete one, the current logic will fail to deferrence
> > 
> > 	err->section_length
> > and
> > 	ctx_info->size
> > 
> > Add checks to avoid that. With such changes, those GHESv2
> > records won't cause OOPSes:
> > 
> >     GUID: e19e3d16-bc11-11e4-9caa-c2051d5d46b0
> >     CPER:
> >       00000000  23 da a0 ce 9a 1b 92 d7 08 2b 32 08 7b 56 1b 23   #........+2.{V.#
> 
> Surely you can summarize this gibberish instead of putting it in the commit
> message.

The dump is a summary. I can expand them if you prefer:

This one is:

Valid                 : cea0da23
Error Info num        : 1b9a
Context Info num      : d792
Section Length        : 08322b08
Error affinity level  : 7b
Reserved              : 231b56
MPIDR_EL1             : d7f357b623aac1d5
MIDR_EL1              : bcdafd2bea32727a
Running State         : e4e3524e
PSCI State            : 75532115

Processor Error Info 0
Version               : e7
Length                : d0
valid                 : 2230
type                  : de
multiple-error        : dbcc
flags                 : ba
error-info            : f0e4896d9956243c
virt-addr             : 255bbcba784df3ac
phy-addr              : af8aee20ac2c9ce5

Processor Error Info 1
Version               : d3
Length                : c1
valid                 : 0209
type                  : fd
multiple-error        : 26a0
flags                 : e4
error-info            : faf1afaf12d14b1b
virt-addr             : 88467ce57d7100ab
phy-addr              : 5f8f03da196e35d7

Processor Error Info 2
Version               : 50
Length                : 51
valid                 : cf68
type                  : 59
multiple-error        : 6d1a
flags                 : 91
error-info            : f4ee81125d53e813
virt-addr             : ef5c45c3b3aede7c
phy-addr              : 130b2ac5f1c82129

Processor Error Info 3
Version               : 9f
Length                : 17
valid                 : cf56
type                  : f2
multiple-error        : ec2b
flags                 : 32
error-info            : 33db30acbc2ee037
virt-addr             : ac0b7c397fda89c0
phy-addr              : cb050f9ae8a5f94f

Processor Error Info 4
Version               : 96
Length                : cb
valid                 : 731a
type                  : 1f
multiple-error        : f40a
flags                 : b5
error-info            : 2f2943cd6b3f020c
virt-addr             : fbeb0d2f2a18bb9e
phy-addr              : 8b121af646c12a80

Processor Error Info 5
Version               : 72
Length                : 87
valid                 : 94d0
type                  : 17
multiple-error        : fcb6
flags                 : 2d
error-info            : 81d1cf1d5d5a074f
virt-addr             : 4a539ab2f341ddd6
phy-addr              : phy-addr: N/A

And the second one is:

Valid                 : 39b2d733
Error Info num        : aa26
Context Info num      : 4c70
Section Length        : d6bbcfbf
Error affinity level  : d5
Reserved              : 4d5931
MPIDR_EL1             : 780488095a3ee67d
MIDR_EL1              : 5229b03dae164778
Running State         : d9c2523e
PSCI State            : 7061046e

Processor Error Info 0
Version               : 42
Length                : 83
valid                 : cdc9
type                  : 45
multiple-error        : c3ad
flags                 : b6
error-info            : 5ff24bfba736d03d
virt-addr             : 15270577f27f908d
phy-addr              : 5da8507f1872c8c0

Processor Error Info 1
Version               : 03
Length                : 4f
valid                 : 2721
type                  : 06
multiple-error        : 29e5
flags                 : bd
error-info            : 31713035d16f3402
virt-addr             : 38da90747c1e221f
phy-addr              : 7f206ee0ede15a70

Processor Error Info 2
Version               : cb
Length                : 05
valid                 : 0282
type                  : a1
multiple-error        : 75d9
flags                 : 66
error-info            : 7ab39560b97d62c4
virt-addr             : 8914ababb9fcc2e8
phy-addr              : e67a83c79a658352

Processor Error Info 3
Version               : 74
Length                : 2f
valid                 : a4c5
type                  : 6a
multiple-error        : 4639
flags                 : 06
error-info            : 0e96f6f4b07cd49e
virt-addr             : f02c4370d9c572da
phy-addr              : c28907b8873fae0e

Processor Error Info 4
Version               : dd
Length                : 54
valid                 : 3ec4
type                  : 1a
multiple-error        : ab0c
flags                 : ae
error-info            : c880d741bc5a8953
virt-addr             : 87994d3c55ab28ff
phy-addr              : 5ddaf72ce811ce42

Processor Error Info 5
Version               : d3
Length                : 99
valid                 : 114e
type                  : 86
multiple-error        : fcd7
flags                 : 36
error-info            : f645ba4659a08fd1
virt-addr             : 8ff1920d3e530341
phy-addr              : 20cc5cae52454998

Processor Error Info 6
Version               : f7
Length                : 08
valid                 : 3b2b
type                  : c0
multiple-error        : 4c3d
flags                 : 16
error-info            : 126a1eecf5a8b295
virt-addr             : 2e3f39d35ce4273a
phy-addr              : 0f12ea75ee9cd762

Processor Error Info 7
Version               : cf
Length                : 09
valid                 : 068a
type                  : 02
multiple-error        : e623
flags                 : 3a
error-info            : ee10f7fa6320cea2
virt-addr             : a0b47d9412515c83
phy-addr              : a1e1ba92699a99a9

Processor Error Info 8
Version               : 60
Length                : d3
valid                 : 5798
type                  : fb
multiple-error        : 3488
flags                 : 7a
error-info            : 70952dae73d0612e
virt-addr             : 70b957b1a032b500
phy-addr              : 1e5da6147837bcf4

Processor Error Info 9
Version               : fa
Length                : a8
valid                 : e854
type                  : 8b
multiple-error        : ea00
flags                 : a9
error-info            : 31ee9be8e9e6a405
virt-addr             : d63c05f14192b118
phy-addr              : 0cf115434ced7dfa

Processor Error Info 10
Version               : 77
Length                : c2
valid                 : 5427
type                  : 2e
multiple-error        : b6e0
flags                 : 44
error-info            : 61630ad6fc5a8c73
virt-addr             : b57d2446fe5b75b3
phy-addr              : 1dc535177d9a8385

Processor Error Info 11
Version               : 69
Length                : dc
valid                 : 1db0
type                  : 61
multiple-error        : 10b3
flags                 : 95
error-info            : 2709522c06f946e1
virt-addr             : 822be010981302c6
phy-addr              : 04a1d4b37ef15c74

Processor Error Info 12
Version               : 58
Length                : 43
valid                 : 3660
type                  : a8
multiple-error        : 227b
flags                 : e7
error-info            : 890b23acfb9cf2e8
virt-addr             : 82a404206aaa4918
phy-addr              : d9d8854296e768c3

Processor Error Info 13
Version               : fc
Length                : d6
valid                 : a4b3
type                  : 5b
multiple-error        : 0297
flags                 : f0
error-info            : 096630aa6386d369
virt-addr             : d432e6b2e2361f7a
phy-addr              : 5431e03da268698d

Processor Error Info 14
Version               : 95
Length                : e6
valid                 : 7682
type                  : 13
multiple-error        : 6c0b
flags                 : d2
error-info            : eec3685677453604
virt-addr             : 00e73d0a1ca3dbb7
phy-addr              : e978c454b499dac0

Processor Error Info 15
Version               : 03
Length                : 23
valid                 : fdd3
type                  : f4
multiple-error        : bd20
flags                 : b2
error-info            : 4c22a60483639c34
virt-addr             : 0115b8bbf8938b95
phy-addr              : b43d7ffa2211e642

Processor Error Info 16
Version               : 1e
Length                : cc
valid                 : c83b
type                  : 4b
multiple-error        : b9d7
flags                 : 7c
error-info            : aa3a7c2dd9531693
virt-addr             : 22ef80cf58eedd09
phy-addr              : b3e9c6018f0b60e2

Processor Error Info 17
Version               : a2
Length                : 2c
valid                 : a2f2
type                  : 48
multiple-error        : 16c2
flags                 : ba
error-info            : 2480ad95fe4262b5
virt-addr             : de4c7d7e23a790b3
phy-addr              : 7b0db92016c7a63e

Processor Error Info 18
Version               : ef
Length                : e2
valid                 : d321
type                  : d9
multiple-error        : ddfc
flags                 : d7
error-info            : 182f81a597b35722
virt-addr             : 12c3e3ccbf830622
phy-addr              : 144208cd5557fd09

Processor Error Info 19
Version               : 4d
Length                : e1
valid                 : 425c
type                  : 02
multiple-error        : 82ae
flags                 : 74
error-info            : d665610e873af29f
virt-addr             : 30067538990d6251
phy-addr              : 44401b9e1182985a

Processor Error Info 20
Version               : 14
Length                : 34
valid                 : d706
type                  : c1
multiple-error        : b324
flags                 : 5e
error-info            : 9bbdba7db12af406
virt-addr             : virt-addr: N/A
phy-addr              : phy-addr: N/A

Both are incomplete records, and were crafted to validate
problems at the GHES parser.

On both dumps, "N/A" means it went past the buffer area.

The above output stops the dump before trying to parse
a next struct once N/A is reached.

-- 
Thanks,
Mauro

