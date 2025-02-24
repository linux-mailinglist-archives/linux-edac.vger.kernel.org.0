Return-Path: <linux-edac+bounces-3194-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C008A42CD1
	for <lists+linux-edac@lfdr.de>; Mon, 24 Feb 2025 20:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4ADF189BD5F
	for <lists+linux-edac@lfdr.de>; Mon, 24 Feb 2025 19:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE159204C26;
	Mon, 24 Feb 2025 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kT18x0Hk"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AA51EA7E9;
	Mon, 24 Feb 2025 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740425833; cv=none; b=Ez5oSGUDLBiaqR39alpK8hB7ANJXWzVHyUiTdLykBSZc7UTI/WTk2e3ohmUIlfBQv7jJrMe0l8HeALe+r/P9CKH6SUL0eAlHHrl5q0ZgWXeGrP7V1ZLx/0ypVBhTFQntLZrjEIfUAACD26quCEegb51B0VkLFMdgXk9Kk9yf9cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740425833; c=relaxed/simple;
	bh=CBPhLQED/x0eN0K2QJEk8i3hB7wXgz7VneaB0fejGrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQ2jQU3EyNCbrnnvifJLiT9MyteW7fDfC1Fe9XulHo3iap8QmFyvCWyK6gF46duBXg++i6BxxjyRmdKDMTiUn9iylLfq7bXeXPmTlDbzd9qfv5QhQxg4qkOLx5NbfdQQlVAY0Xd/GUq2ESwSvK2BvFuxt1xL7cEleWNn5j0QUxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kT18x0Hk reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D6FCF40E01A3;
	Mon, 24 Feb 2025 19:37:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IKUAZOsL-R_7; Mon, 24 Feb 2025 19:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740425820; bh=/I7UvVp78GuoiFfwU5oCzidB3aFWz97s8y37YiINiW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kT18x0HkzoNNjITX7Y1H0zFXAeJC8KhjcBMlzgogcFebS6uSQ+xMy8b+fFWJvMXFY
	 oNQia6JMcQJSYF8qZ/IF2iWa8futXxRutYl3f/A/k/+lDKCVL7hmeY71ucQ9OmcQaY
	 LFxA6X+deIT3WzSiiIvoi1Dt96SLEoEFSgG0AN/i0tboUcO9wLn1g8sTIASRQG5FCU
	 bHDvd2HDpeCYEjr/AFBcGu0XhqUkg4DCnwJo0FXT252RwT7683tKcgaUDy7n7VmXRb
	 cxFfdFcfOal/qwylPkPoB0oNXnKUhNfdHFaKdxbAidqZsEWtAWuJSN9FVoqNjeloT9
	 Wwp6PYYYvlIqwiCuRhRnBkdqfwuktKmsn6RChjFEYP4bQVZJZIXXhgs3HZivPM1apA
	 FIoDR7VdJA7lxRMIObtNg5zsnb9sq6f4A3KNV+slNi3KuVqeU10c3UVaHKYvfHpTJX
	 FD6QWc30VS7dvbycZMUoDD69NQWFO5B3MUhjDCjp/SOlT8brQ27qIWtyEa0fmYDWVm
	 AixotFlxrj05ky+j2KUgKwIOR5MRxV4XCz/cmfBFiGlKEBDdkb9RBGQ+Tu+2lBeD88
	 dYFiS+jNw3bi6h90zMz7v4vXeAqb8JZkiHcGs2iHdnEET2VQ1C/8o+/fJqSEPd3VsQ
	 +0uJXgy5nBAcPn9NDNHEFRu8=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9CBA140E0184;
	Mon, 24 Feb 2025 19:36:15 +0000 (UTC)
Date: Mon, 24 Feb 2025 20:36:08 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
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
Subject: Re: [PATCH v20 00/15] EDAC: Scrub: introduce generic EDAC RAS
 control feature driver + CXL/ACPI-RAS2 drivers
Message-ID: <20250224193608.GBZ7zKKAumB312YZnA@fat_crate.local>
References: <20250212143654.1893-1-shiju.jose@huawei.com>
 <20250224115002.GCZ7xc6o3yA1Q2j85i@fat_crate.local>
 <71ad0c8c6a304b2d9a62f49983c3d787@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <71ad0c8c6a304b2d9a62f49983c3d787@huawei.com>
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 06:30:48PM +0000, Shiju Jose wrote:
> Testing rest of the patches for CXL RAS features and ACPI RAS2 scrub fe=
ature
> in this branch are worked fine.

Thanks.

Unfortunately, my randbuild tests trigger issues:

In file included from drivers/edac/mem_repair.c:12:
In file included from ./include/linux/edac.h:16:
In file included from ./include/linux/device.h:15:
In file included from ./include/linux/dev_printk.h:16:
In file included from ./include/linux/ratelimit.h:6:
In file included from ./include/linux/sched.h:13:
In file included from ./arch/x86/include/asm/processor.h:19:
In file included from ./arch/x86/include/asm/cpuid.h:71:
In file included from ./arch/x86/include/asm/paravirt.h:21:
In file included from ./include/linux/cpumask.h:12:
In file included from ./include/linux/bitmap.h:13:
In file included from ./include/linux/string.h:392:
./include/linux/fortify-string.h:571:4: error: call to '__write_overflow_=
field' declared with 'warning' attribute: detected write beyond size of f=
ield (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warn=
ing]
  571 |                         __write_overflow_field(p_size_field, size=
);
      |                         ^
1 error generated.
make[4]: *** [scripts/Makefile.build:207: drivers/edac/mem_repair.o] Erro=
r 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:465: drivers/edac] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:465: drivers] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/home/amd/kernel/linux/Makefile:1989: .] Error 2
make: *** [Makefile:251: __sub-make] Error 2

That's a allmodconfig-x86_64-clang build.

gcc triggers it too:

In file included from ./include/linux/string.h:392,
                 from ./include/linux/bitmap.h:13,
                 from ./include/linux/cpumask.h:12,
                 from ./arch/x86/include/asm/paravirt.h:21,
                 from ./arch/x86/include/asm/cpuid.h:71,
                 from ./arch/x86/include/asm/processor.h:19,
                 from ./include/linux/sched.h:13,
                 from ./include/linux/ratelimit.h:6,
                 from ./include/linux/dev_printk.h:16,
                 from ./include/linux/device.h:15,
                 from ./include/linux/edac.h:16,
                 from drivers/edac/mem_repair.c:12:
In function =E2=80=98fortify_memcpy_chk=E2=80=99,
    inlined from =E2=80=98mem_repair_create_desc=E2=80=99 at drivers/edac=
/mem_repair.c:325:3:
./include/linux/fortify-string.h:571:25: error: call to =E2=80=98__write_=
overflow_field=E2=80=99 declared with attribute warning: detected write b=
eyond size of field (1st parameter); maybe use struct_group()? [-Werror=3D=
attribute-warning]
  571 |                         __write_overflow_field(p_size_field, size=
);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
cc1: all warnings being treated as errors
make[4]: *** [scripts/Makefile.build:207: drivers/edac/mem_repair.o] Erro=
r 1
make[3]: *** [scripts/Makefile.build:465: drivers/edac] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:465: drivers] Error 2
make[1]: *** [/home/amd/kernel/linux/Makefile:1989: .] Error 2
make: *** [Makefile:251: __sub-make] Error 2
11-22-09-allmodconfig-x86_64-20849.log (END)

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

