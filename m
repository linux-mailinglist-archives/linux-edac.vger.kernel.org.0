Return-Path: <linux-edac+bounces-3029-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E14FA316D0
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 21:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169FF3A885E
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 20:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD0E2641C3;
	Tue, 11 Feb 2025 20:42:27 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7361D89E5;
	Tue, 11 Feb 2025 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739306547; cv=none; b=M3R6Y1gY3f1+ILWOGP0od2yMc7Et44IAPQfDaBn4RyykDKBr84pwQYYQmBv422vIsGPxFUvelKnYZad14s0SxiViwOXUKZLgHeCdhvi3GxOGtV1nDhqClFVwvXwDw3/dIYQXgcBqmePop2X5Lx1L5hn6L2KEP0bhnIvhww2vd9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739306547; c=relaxed/simple;
	bh=I7akJBwRiTP9CbfLL05hx9JniHdTpAdfGXEoDL07HKQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V6n4i7FedueHxKu6few2GXQ3LeDQYZKJLA0RP8vij7594sth0+Dvi70BU6ThTLy2pphaChkbAmV9tIgTMaHCdglWXoP/4DQlYVzRBTpN7xZib0I3WNYpAcP3kI4C+9Ek7p9zd5GwHckJp1+tyl3GXNM7zRiAQbhZF9dmTicCShI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YstbG71Tyz6L56q;
	Wed, 12 Feb 2025 04:39:22 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
	by mail.maildlp.com (Postfix) with ESMTPS id E44BC1400DD;
	Wed, 12 Feb 2025 04:42:20 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Feb 2025 21:42:20 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 11 Feb 2025 21:42:20 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Fan Ni <nifan.cxl@gmail.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
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
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>, "a.manzanares@samsung.com"
	<a.manzanares@samsung.com>, "nmtadam.samsung@gmail.com"
	<nmtadam.samsung@gmail.com>, "anisa.su887@gmail.com" <anisa.su887@gmail.com>
Subject: RE: [PATCH v19 00/15] EDAC: Scrub: introduce generic EDAC RAS control
 feature driver + CXL/ACPI-RAS2 drivers
Thread-Topic: [PATCH v19 00/15] EDAC: Scrub: introduce generic EDAC RAS
 control feature driver + CXL/ACPI-RAS2 drivers
Thread-Index: AQHbeW7q+yAlb0l8b0m3xpFA4TlX9rNAxY6AgAF8IfCAACR1AIAAMBhg
Date: Tue, 11 Feb 2025 20:42:20 +0000
Message-ID: <04b3b2608db74f78ba88cf434108fcac@huawei.com>
References: <20250207144445.1879-1-shiju.jose@huawei.com>
 <Z6o87wa-tabDy34V@fan> <c2fe65c81ab4484f977f5938a3278036@huawei.com>
 <Z6uaZOWlDd3OWcZl@fan>
In-Reply-To: <Z6uaZOWlDd3OWcZl@fan>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



>-----Original Message-----
>From: Fan Ni <nifan.cxl@gmail.com>
>Sent: 11 February 2025 18:44
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: Fan Ni <nifan.cxl@gmail.com>; linux-edac@vger.kernel.org; linux-
>cxl@vger.kernel.org; linux-acpi@vger.kernel.org; linux-mm@kvack.org; linux=
-
>kernel@vger.kernel.org; linux-doc@vger.kernel.org; bp@alien8.de;
>tony.luck@intel.com; rafael@kernel.org; lenb@kernel.org;
>mchehab@kernel.org; dan.j.williams@intel.com; dave@stgolabs.net; Jonathan
>Cameron <jonathan.cameron@huawei.com>; dave.jiang@intel.com;
>alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>david@redhat.com; Vilas.Sridharan@amd.com; leo.duran@amd.com;
>Yazen.Ghannam@amd.com; rientjes@google.com; jiaqiyan@google.com;
>Jon.Grimm@amd.com; dave.hansen@linux.intel.com;
>naoya.horiguchi@nec.com; james.morse@arm.com; jthoughton@google.com;
>somasundaram.a@hpe.com; erdemaktas@google.com; pgonda@google.com;
>duenwen@google.com; gthelen@google.com;
>wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
>wbs@os.amperecomputing.com; tanxiaofei <tanxiaofei@huawei.com>; Zengtao
>(B) <prime.zeng@hisilicon.com>; Roberto Sassu <roberto.sassu@huawei.com>;
>kangkang.shen@futurewei.com; wanghuiqiang <wanghuiqiang@huawei.com>;
>Linuxarm <linuxarm@huawei.com>; a.manzanares@samsung.com;
>nmtadam.samsung@gmail.com; anisa.su887@gmail.com
>Subject: Re: [PATCH v19 00/15] EDAC: Scrub: introduce generic EDAC RAS
>control feature driver + CXL/ACPI-RAS2 drivers
>
>On Tue, Feb 11, 2025 at 04:55:49PM +0000, Shiju Jose wrote:
>> >-----Original Message-----
>> >From: Fan Ni <nifan.cxl@gmail.com>
>> >Sent: 10 February 2025 17:53
>> >To: Shiju Jose <shiju.jose@huawei.com>
>> >Cc: linux-edac@vger.kernel.org; linux-cxl@vger.kernel.org; linux-
>> >acpi@vger.kernel.org; linux-mm@kvack.org;
>> >linux-kernel@vger.kernel.org; linux-doc@vger.kernel.org;
>> >bp@alien8.de; tony.luck@intel.com; rafael@kernel.org;
>> >lenb@kernel.org; mchehab@kernel.org; dan.j.williams@intel.com;
>> >dave@stgolabs.net; Jonathan Cameron <jonathan.cameron@huawei.com>;
>> >dave.jiang@intel.com; alison.schofield@intel.com;
>> >vishal.l.verma@intel.com; ira.weiny@intel.com; david@redhat.com;
>> >Vilas.Sridharan@amd.com; leo.duran@amd.com;
>Yazen.Ghannam@amd.com;
>> >rientjes@google.com; jiaqiyan@google.com; Jon.Grimm@amd.com;
>> >dave.hansen@linux.intel.com; naoya.horiguchi@nec.com;
>> >james.morse@arm.com; jthoughton@google.com;
>somasundaram.a@hpe.com;
>> >erdemaktas@google.com; pgonda@google.com; duenwen@google.com;
>> >gthelen@google.com; wschwartz@amperecomputing.com;
>> >dferguson@amperecomputing.com; wbs@os.amperecomputing.com;
>> >nifan.cxl@gmail.com; tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B)
>> ><prime.zeng@hisilicon.com>; Roberto Sassu <roberto.sassu@huawei.com>;
>> >kangkang.shen@futurewei.com; wanghuiqiang
><wanghuiqiang@huawei.com>;
>> >Linuxarm <linuxarm@huawei.com>; a.manzanares@samsung.com;
>> >nmtadam.samsung@gmail.com; anisa.su887@gmail.com
>> >Subject: Re: [PATCH v19 00/15] EDAC: Scrub: introduce generic EDAC
>> >RAS control feature driver + CXL/ACPI-RAS2 drivers
>> >
>> >On Fri, Feb 07, 2025 at 02:44:29PM +0000, shiju.jose@huawei.com wrote:
>> >> From: Shiju Jose <shiju.jose@huawei.com>
>> >>
>> >> The CXL patches of this series has dependency on Dave's CXL fwctl
>> >> series [1].
>> >>
>> >> The code is based on v3 of CXL fwctl series [1] posted by Dave and
>> >> v3 of FWCTL series [2] posted by Jason and rebased on top of
>> >> v6.14-rc1.
>> >>
>> >> [1]:
>> >> https://lore.kernel.org/linux-cxl/20250204220430.4146187-1-dave.jia
>> >> ng@
>> >> intel.com/
>> >> [2]:
>> >> https://lore.kernel.org/linux-cxl/0-v3-960f17f90f17+516-fwctl_jgg@n
>> >> vid
>> >> ia.com/#r
>> >>
>> >>
>> >> Userspace code for CXL memory repair features [3] and sample
>> >> boot-script for CXL memory repair [4].
>> >>
>> >> [3]:
>> >> https://lore.kernel.org/lkml/20250207143028.1865-1-shiju.jose@huawe
>> >> i.c
>> >> om/
>> >> [4]:
>> >> https://lore.kernel.org/lkml/20250207143028.1865-5-shiju.jose@huawe
>> >> i.c
>> >> om/
>> >>
>> >
>> >Hi Shiju,
>> >Is this series the same as in branch
>> >https://github.com/shijujose4/linux/tree/edac-enhancement-ras-
>features_v19?
>> >
>> >I hit some compile errors wen trying to test with the above branch dire=
ctly.
>> >
>> >Here are two cases where I found the code cannot compile. Please
>> >check if it is a false alarm.
>> >
>> >Case 1: CONFIG_CXL_RAS_FEATURES=3Dm
>...
>> >
>> >fan:~/cxl/linux-edac$ make -j16
>> >mkdir -p /home/fan/cxl/linux-edac/tools/objtool && make
>> >O=3D/home/fan/cxl/linux-edac subdir=3Dtools/objtool --no-print-director=
y -C
>objtool
>> >  CALL    scripts/checksyscalls.sh
>> >  INSTALL libsubcmd_headers
>> >  UPD     include/generated/utsversion.h
>> >  CC      init/version-timestamp.o
>> >  KSYMS   .tmp_vmlinux0.kallsyms.S
>> >  AS      .tmp_vmlinux0.kallsyms.o
>> >  LD      .tmp_vmlinux1
>> >ld: vmlinux.o: in function `cxl_region_probe':
>> >/home/fan/cxl/linux-edac/drivers/cxl/core/region.c:3456:(.text+0x7b296f=
):
>> >undefined reference to `devm_cxl_region_edac_register'
>> >ld: vmlinux.o: in function `cxl_mem_probe':
>> >/home/fan/cxl/linux-edac/drivers/cxl/mem.c:188:(.text+0x7b8ad1):
>> >undefined reference to `devm_cxl_memdev_edac_register'
>> >make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
>> >make[1]: *** [/home/fan/cxl/linux-edac/Makefile:1226: vmlinux] Error
>> >2
>> >make: *** [Makefile:251: __sub-make] Error 2
>> >
>> >When compile with CONFIG_CXL_RAS_FEATURES=3Dy,  it can compile.
>> >
>> Hi Fan,
>>
>> Thanks for checking this and reporting.
>>
>> This error is with CONFIG_CXL_RAS_FEATURES=3Dm and CONFIG_CXL_BUS=3Dy
>and CONFIG_CXL_MEM=3Dy.
>> Now changed  CONFIG_CXL_RAS_FEATURES  for tristate -> boolean as this
>> implemented only interface functions for the CXL RAS features.
>> >
>> >CASE 2: CONFIG_EDAC=3Dm
>> >
>...
>> >fan:~/cxl/linux-edac$ make -j16
>> >mkdir -p /home/fan/cxl/linux-edac/tools/objtool && make
>> >O=3D/home/fan/cxl/linux-edac subdir=3Dtools/objtool --no-print-director=
y -C
>objtool
>> >  CALL    scripts/checksyscalls.sh
>> >  INSTALL libsubcmd_headers
>> >  UPD     include/generated/utsversion.h
>> >  CC      init/version-timestamp.o
>> >  KSYMS   .tmp_vmlinux0.kallsyms.S
>> >  AS      .tmp_vmlinux0.kallsyms.o
>> >  LD      .tmp_vmlinux1
>> >ld: vmlinux.o: in function `devm_cxl_region_edac_register':
>> >/home/fan/cxl/linux-
>> >edac/drivers/cxl/core/memfeature.c:1720:(.text+0x7b665d): undefined
>> >reference to `edac_dev_register'
>> >ld: vmlinux.o: in function `devm_cxl_memdev_edac_register':
>> >/home/fan/cxl/linux-
>> >edac/drivers/cxl/core/memfeature.c:1697:(.text+0x7b7241): undefined
>> >reference to `edac_dev_register'
>> >ld: vmlinux.o: in function `ras2_probe':
>> >/home/fan/cxl/linux-edac/drivers/ras/acpi_ras2.c:363:(.text+0xb0ecc8):
>> >undefined reference to `edac_dev_register'
>> >make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
>> >make[1]: *** [/home/fan/cxl/linux-edac/Makefile:1226: vmlinux] Error
>> >2
>> >make: *** [Makefile:251: __sub-make] Error 2
>> >
>>
>> Here the symbol 'edac_dev_register' can't find with CONFIG_CXL_BUS=3Dy
>> CONFIG_CXL_RAS_FEATURES=3Dy and CONFIG_EDAC=3Dm.
>> Modified CXL_RAS_FEATURES depends on EDAC=3Dy || (CXL_BUS=3Dm &&
>EDAC=3Dm)
>> to fix this.
>Hi Shiju,
>Did you mean the following fix?
>
>diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig index
>77baef31cf3c..8615f329baa2 100644
>--- a/drivers/cxl/Kconfig
>+++ b/drivers/cxl/Kconfig
>@@ -162,11 +162,12 @@ config CXL_REGION_INVALIDATION_TEST
>          say N.
>
> config CXL_RAS_FEATURES
>-       tristate "CXL: Memory RAS features"
>+       bool "CXL: Memory RAS features"
>        depends on CXL_MEM
>        depends on EDAC_SCRUB
>        depends on EDAC_ECS
>        depends on EDAC_MEM_REPAIR
>+       depends on EDAC=3Dy || (CXL_BUS=3Dm && EDAC=3Dm)
>        help
>          The CXL memory RAS feature control is optional and allows host t=
o
>          control the RAS features configurations of CXL Type 3 devices.

Hi Fan,

Yes.=20
>
>
>
>With the fix, I still see the errors with following config.

Sorry. I did not shared the RAS2 Kconfig change, assuming you are checking =
the CXL part only.
Please see RAS2 change, which require some improvements for the case CONFIG=
_MEM_ACPI_RAS2=3Dm.=20

diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig index c907e44360c8..=
881d6a642457 100644
--- a/drivers/ras/Kconfig
+++ b/drivers/ras/Kconfig
@@ -49,7 +49,7 @@ config RAS_FMPM
 config MEM_ACPI_RAS2
        tristate "Memory ACPI RAS2 driver"
        depends on ACPI_RAS2
-       depends on EDAC_SCRUB
+       depends on EDAC=3Dy && EDAC_SCRUB
        help
          The driver binds to the platform device added by the ACPI RAS2
          table parser. Use a PCC channel subspace for communicating with =
=20


Thanks,
Shiju
>
>fan:~/cxl/linux-edac$ cat .config | egrep "EDAC|CXL|RAS" | grep -v "^#"
>CONFIG_ACPI_RAS2=3Dy
>CONFIG_ACPI_APEI_EINJ_CXL=3Dy
>CONFIG_PCIEAER_CXL=3Dy
>CONFIG_CXL_BUS=3Dm
>CONFIG_CXL_PCI=3Dm
>CONFIG_CXL_MEM_RAW_COMMANDS=3Dy
>CONFIG_CXL_ACPI=3Dm
>CONFIG_CXL_PMEM=3Dm
>CONFIG_CXL_MEM=3Dm
>CONFIG_CXL_FWCTL=3Dy
>CONFIG_CXL_PORT=3Dm
>CONFIG_CXL_SUSPEND=3Dy
>CONFIG_CXL_REGION=3Dy
>CONFIG_CXL_REGION_INVALIDATION_TEST=3Dy
>CONFIG_CXL_RAS_FEATURES=3Dy
>CONFIG_MMC_SDHCI_OF_ARASAN=3Dy
>CONFIG_EDAC_ATOMIC_SCRUB=3Dy
>CONFIG_EDAC_SUPPORT=3Dy
>CONFIG_EDAC=3Dm
>CONFIG_EDAC_LEGACY_SYSFS=3Dy
>CONFIG_EDAC_DEBUG=3Dy
>CONFIG_EDAC_DECODE_MCE=3Dm
>CONFIG_EDAC_GHES=3Dm
>CONFIG_EDAC_SCRUB=3Dy
>CONFIG_EDAC_ECS=3Dy
>CONFIG_EDAC_MEM_REPAIR=3Dy
>CONFIG_EDAC_IGEN6=3Dm
>CONFIG_RAS=3Dy
>CONFIG_MEM_ACPI_RAS2=3Dy
>CONFIG_DEV_DAX_CXL=3Dm
>
>ld: vmlinux.o: in function `ras2_probe':
>/home/fan/cxl/linux-edac/drivers/ras/acpi_ras2.c:363:(.text+0xaeb5c8):
>undefined reference to `edac_dev_register'
>make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
>make[1]: *** [/home/fan/cxl/linux-edac/Makefile:1226: vmlinux] Error 2
>make: *** [Makefile:251: __sub-make] Error 2
>
>It seems ACPI_RAS2 depends on EDAC.
>When changing CONFIG_EDAC=3Dy, it compiles fine.
>
>Fan
[...]


