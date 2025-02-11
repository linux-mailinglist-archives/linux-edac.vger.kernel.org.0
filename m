Return-Path: <linux-edac+bounces-3027-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE2CA31446
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 19:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 491F97A22A8
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 18:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F236253B43;
	Tue, 11 Feb 2025 18:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtTHyYxw"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8E21E47A8;
	Tue, 11 Feb 2025 18:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739299446; cv=none; b=RD2BdjYvBlBGJ94zIdch3clTZpyRlBTTqXaHoJxQKSqcWhP+ghOsBlYKahcphM45ZLEHqnBjLhI/CmVJppIS4g4vxf0X1JygaYn6KmFt7owTIRfQK7pCq836DaJs2qAfoDEUanmx6I5ZP78Lrj88nNRioEJfcdEVdVNyPo4WFwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739299446; c=relaxed/simple;
	bh=Ql6wRnDsroFbMre0iajGStSt79fUCdAiEy9QzoV9OPc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCVjHyYn7587ibAYkNJk1agTbsTcz+St0dmnuJyplM9ysiuE1jdOHt1WB5tb60sLRLhuLeX51dYEtQ4ntp9fjzNx4R0aPX68x1Q36pFhvweW6ZhMOUUhxhF/d2CZMu0248u4UNEzvv/KfR9Tzhkwq0jlcs5pXkBJSqwDIfRM1eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtTHyYxw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-219f8263ae0so106258685ad.0;
        Tue, 11 Feb 2025 10:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739299443; x=1739904243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=12Y6R9YRZk8Jue/FVtlF2Z1F8YliyMggH+wBJrK9OAk=;
        b=GtTHyYxwtK8d29nUmBjm5WT++n3GopHARnmwdao9MZ+gnLDhYbiunL8asQM1tNYrkM
         0DuNvFPsBPNte9gZEmma7/57yzpKQVFSXeIuKIZwTKvsgVH7D9EZi3THO/vReg3SlqDI
         CTUaXGedW7pEeRGJEv9IsgoAOacKoUUjEBegmdKJEXZwMKZ1X4Jv/jVrZ6FSD6ZXYxH+
         HA5JBqTQLM27GChh3kV1RieALAACQqw54UiJR7m+f+lgBCISbuOhSrlV0hhN95AeON0V
         XkVW+cm06QDlpf52YHfPNVeW+diK57sjkmYQghYgab+gZ++n7gL7nshoKn3kUuChLOpu
         IaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739299443; x=1739904243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12Y6R9YRZk8Jue/FVtlF2Z1F8YliyMggH+wBJrK9OAk=;
        b=KiwyCWr/gojBR2fR8tzxDXiBHYIKeARuSO2bBA+/e0qk4khqS8pVIT27SWLB64ndF1
         AvoMjggdXLqiNgHQKAGeoVGgOmNF6WrvWQuV5CG+Eu9stiac0gHFfgyOo77h4wVmtTTi
         rSyecuuGIJriXoW0JgfgjiZp9HKnTkZbK0tE9qSJp0XZwD5PPK+htKWaPlNYwsXrIHPz
         NH/ghdMs6kjL0kW3L9LAtq7vRAsr7L7IbKgrOxItMRuleslMLF2hXb5BpLyoX3TqFg8q
         mhin0tRWkCHn3q1xf6s8/eEj7mZsNo+Ag4pqtqQPJ/EH+cqqTVP7SI6YWEkkXXEHsmEG
         sFgA==
X-Forwarded-Encrypted: i=1; AJvYcCU24ARweSRZ7gN1kzY954L7xhPuqQ9GU+X52vIVoeH1EYncuXTyj2H7OxpqlW7TRPGbaM+zR5uiAtIj@vger.kernel.org, AJvYcCUnFLRwt7FtUq4dIvm2S/ZtmPUYW7qK4Dwe1aw14hQysVDVYb0+mcSqHryjW6jdXpWeS3ObjGjND4hXf91f@vger.kernel.org, AJvYcCVgWlh1eUXKqNlMwyEDuNNWhtw36VRG80MjAVxOZYvtM2PvRpHqVla3uis7HrBPmcEvnyOL/Y1HCBXMeQ==@vger.kernel.org, AJvYcCW9hTip3sjbxDrNG87m5gE1qpYhpZ+vi8fQDk4HtkBVaXw2zTVjlBW3iITjdca5iuz+sDpjSsMyba4h@vger.kernel.org, AJvYcCWxLY3MpzZ7+dIrrukhFnlc5i0loUM18tAjmq2/cieTsbUUHBDBV83U7cq6gPwo8akI9Il8iquBzTZF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Snf2gYKmpHlK06Q8nxIkSM1JCd5Ha+PD+eV4iPsynRF7lv4d
	1ck1aibzQxyI6/b2Jqkg5WBJSnHb6AAYx8zCyBZi+918nPMkQ9e0
X-Gm-Gg: ASbGnculGR0mY4n5wEMrPXKpZZWP606wzufnTHKjWaTIou6pmckX6LBdlAV23OWpSld
	BWi5Gqz73+sJSQowh3ZnXU8oHzv8d44pcB+pciI25QuJ2GUCC6ypo1tj9EcbL78CaDri55TNBC+
	NI1NR2qYsQCGVbJC2wqbiBmYyxZv7kXbwwtJ71Q6AGI9UM/Qbo3k4bimCv4QdrgK1T4CDSVHNee
	UdIbFiVLj5Vq3DrZ6ZKF0W7bSSWNeLMceQkcb0aMfgl7XCKjJyAuNZWSL//JpJqhonK0UWzKMPn
	QDRhIw==
X-Google-Smtp-Source: AGHT+IFkGi3oAlql1pNuNzs7aio5LNXqemb+oRz2/bDSC6hWtZUaUvFojExrPWEhZjADSKbDaLK6dw==
X-Received: by 2002:a05:6a20:2d12:b0:1ee:2550:e811 with SMTP id adf61e73a8af0-1ee5c739702mr680238637.14.1739299443297;
        Tue, 11 Feb 2025 10:44:03 -0800 (PST)
Received: from fan ([2601:646:8f03:9fe0:a440:5911:e4a4:e315])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73218c206a6sm1879443b3a.49.2025.02.11.10.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 10:44:02 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 11 Feb 2025 10:43:48 -0800
To: Shiju Jose <shiju.jose@huawei.com>
Cc: Fan Ni <nifan.cxl@gmail.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>,
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
	tanxiaofei <tanxiaofei@huawei.com>,
	"Zengtao (B)" <prime.zeng@hisilicon.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>,
	wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>,
	"a.manzanares@samsung.com" <a.manzanares@samsung.com>,
	"nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
	"anisa.su887@gmail.com" <anisa.su887@gmail.com>
Subject: Re: [PATCH v19 00/15] EDAC: Scrub: introduce generic EDAC RAS
 control feature driver + CXL/ACPI-RAS2 drivers
Message-ID: <Z6uaZOWlDd3OWcZl@fan>
References: <20250207144445.1879-1-shiju.jose@huawei.com>
 <Z6o87wa-tabDy34V@fan>
 <c2fe65c81ab4484f977f5938a3278036@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2fe65c81ab4484f977f5938a3278036@huawei.com>

On Tue, Feb 11, 2025 at 04:55:49PM +0000, Shiju Jose wrote:
> >-----Original Message-----
> >From: Fan Ni <nifan.cxl@gmail.com>
> >Sent: 10 February 2025 17:53
> >To: Shiju Jose <shiju.jose@huawei.com>
> >Cc: linux-edac@vger.kernel.org; linux-cxl@vger.kernel.org; linux-
> >acpi@vger.kernel.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org;
> >linux-doc@vger.kernel.org; bp@alien8.de; tony.luck@intel.com;
> >rafael@kernel.org; lenb@kernel.org; mchehab@kernel.org;
> >dan.j.williams@intel.com; dave@stgolabs.net; Jonathan Cameron
> ><jonathan.cameron@huawei.com>; dave.jiang@intel.com;
> >alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
> >david@redhat.com; Vilas.Sridharan@amd.com; leo.duran@amd.com;
> >Yazen.Ghannam@amd.com; rientjes@google.com; jiaqiyan@google.com;
> >Jon.Grimm@amd.com; dave.hansen@linux.intel.com;
> >naoya.horiguchi@nec.com; james.morse@arm.com; jthoughton@google.com;
> >somasundaram.a@hpe.com; erdemaktas@google.com; pgonda@google.com;
> >duenwen@google.com; gthelen@google.com;
> >wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
> >wbs@os.amperecomputing.com; nifan.cxl@gmail.com; tanxiaofei
> ><tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; Roberto
> >Sassu <roberto.sassu@huawei.com>; kangkang.shen@futurewei.com;
> >wanghuiqiang <wanghuiqiang@huawei.com>; Linuxarm
> ><linuxarm@huawei.com>; a.manzanares@samsung.com;
> >nmtadam.samsung@gmail.com; anisa.su887@gmail.com
> >Subject: Re: [PATCH v19 00/15] EDAC: Scrub: introduce generic EDAC RAS
> >control feature driver + CXL/ACPI-RAS2 drivers
> >
> >On Fri, Feb 07, 2025 at 02:44:29PM +0000, shiju.jose@huawei.com wrote:
> >> From: Shiju Jose <shiju.jose@huawei.com>
> >>
> >> The CXL patches of this series has dependency on Dave's CXL fwctl
> >> series [1].
> >>
> >> The code is based on v3 of CXL fwctl series [1] posted by Dave and
> >> v3 of FWCTL series [2] posted by Jason and rebased on top of
> >> v6.14-rc1.
> >>
> >> [1]:
> >> https://lore.kernel.org/linux-cxl/20250204220430.4146187-1-dave.jiang@
> >> intel.com/
> >> [2]:
> >> https://lore.kernel.org/linux-cxl/0-v3-960f17f90f17+516-fwctl_jgg@nvid
> >> ia.com/#r
> >>
> >>
> >> Userspace code for CXL memory repair features [3] and sample
> >> boot-script for CXL memory repair [4].
> >>
> >> [3]:
> >> https://lore.kernel.org/lkml/20250207143028.1865-1-shiju.jose@huawei.c
> >> om/
> >> [4]:
> >> https://lore.kernel.org/lkml/20250207143028.1865-5-shiju.jose@huawei.c
> >> om/
> >>
> >
> >Hi Shiju,
> >Is this series the same as in branch
> >https://github.com/shijujose4/linux/tree/edac-enhancement-ras-features_v19?
> >
> >I hit some compile errors wen trying to test with the above branch directly.
> >
> >Here are two cases where I found the code cannot compile. Please check if it is a
> >false alarm.
> >
> >Case 1: CONFIG_CXL_RAS_FEATURES=m
...
> >
> >fan:~/cxl/linux-edac$ make -j16
> >mkdir -p /home/fan/cxl/linux-edac/tools/objtool && make
> >O=/home/fan/cxl/linux-edac subdir=tools/objtool --no-print-directory -C objtool
> >  CALL    scripts/checksyscalls.sh
> >  INSTALL libsubcmd_headers
> >  UPD     include/generated/utsversion.h
> >  CC      init/version-timestamp.o
> >  KSYMS   .tmp_vmlinux0.kallsyms.S
> >  AS      .tmp_vmlinux0.kallsyms.o
> >  LD      .tmp_vmlinux1
> >ld: vmlinux.o: in function `cxl_region_probe':
> >/home/fan/cxl/linux-edac/drivers/cxl/core/region.c:3456:(.text+0x7b296f):
> >undefined reference to `devm_cxl_region_edac_register'
> >ld: vmlinux.o: in function `cxl_mem_probe':
> >/home/fan/cxl/linux-edac/drivers/cxl/mem.c:188:(.text+0x7b8ad1): undefined
> >reference to `devm_cxl_memdev_edac_register'
> >make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
> >make[1]: *** [/home/fan/cxl/linux-edac/Makefile:1226: vmlinux] Error 2
> >make: *** [Makefile:251: __sub-make] Error 2
> >
> >When compile with CONFIG_CXL_RAS_FEATURES=y,  it can compile.
> >
> Hi Fan,
> 
> Thanks for checking this and reporting.
> 
> This error is with CONFIG_CXL_RAS_FEATURES=m and CONFIG_CXL_BUS=y and CONFIG_CXL_MEM=y.
> Now changed  CONFIG_CXL_RAS_FEATURES  for tristate -> boolean as this implemented only interface functions
> for the CXL RAS features.
> >
> >CASE 2: CONFIG_EDAC=m
> >
... 
> >fan:~/cxl/linux-edac$ make -j16
> >mkdir -p /home/fan/cxl/linux-edac/tools/objtool && make
> >O=/home/fan/cxl/linux-edac subdir=tools/objtool --no-print-directory -C objtool
> >  CALL    scripts/checksyscalls.sh
> >  INSTALL libsubcmd_headers
> >  UPD     include/generated/utsversion.h
> >  CC      init/version-timestamp.o
> >  KSYMS   .tmp_vmlinux0.kallsyms.S
> >  AS      .tmp_vmlinux0.kallsyms.o
> >  LD      .tmp_vmlinux1
> >ld: vmlinux.o: in function `devm_cxl_region_edac_register':
> >/home/fan/cxl/linux-
> >edac/drivers/cxl/core/memfeature.c:1720:(.text+0x7b665d): undefined
> >reference to `edac_dev_register'
> >ld: vmlinux.o: in function `devm_cxl_memdev_edac_register':
> >/home/fan/cxl/linux-
> >edac/drivers/cxl/core/memfeature.c:1697:(.text+0x7b7241): undefined
> >reference to `edac_dev_register'
> >ld: vmlinux.o: in function `ras2_probe':
> >/home/fan/cxl/linux-edac/drivers/ras/acpi_ras2.c:363:(.text+0xb0ecc8):
> >undefined reference to `edac_dev_register'
> >make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
> >make[1]: *** [/home/fan/cxl/linux-edac/Makefile:1226: vmlinux] Error 2
> >make: *** [Makefile:251: __sub-make] Error 2
> >
> 
> Here the symbol 'edac_dev_register' can't find with CONFIG_CXL_BUS=y  CONFIG_CXL_RAS_FEATURES=y and 
> CONFIG_EDAC=m.
> Modified CXL_RAS_FEATURES depends on EDAC=y || (CXL_BUS=m && EDAC=m)
> to fix this.
Hi Shiju,
Did you mean the following fix?

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 77baef31cf3c..8615f329baa2 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -162,11 +162,12 @@ config CXL_REGION_INVALIDATION_TEST
          say N.

 config CXL_RAS_FEATURES
-       tristate "CXL: Memory RAS features"
+       bool "CXL: Memory RAS features"
        depends on CXL_MEM
        depends on EDAC_SCRUB
        depends on EDAC_ECS
        depends on EDAC_MEM_REPAIR
+       depends on EDAC=y || (CXL_BUS=m && EDAC=m)
        help
          The CXL memory RAS feature control is optional and allows host to
          control the RAS features configurations of CXL Type 3 devices.



With the fix, I still see the errors with following config.

fan:~/cxl/linux-edac$ cat .config | egrep "EDAC|CXL|RAS" | grep -v "^#"
CONFIG_ACPI_RAS2=y
CONFIG_ACPI_APEI_EINJ_CXL=y
CONFIG_PCIEAER_CXL=y
CONFIG_CXL_BUS=m
CONFIG_CXL_PCI=m
CONFIG_CXL_MEM_RAW_COMMANDS=y
CONFIG_CXL_ACPI=m
CONFIG_CXL_PMEM=m
CONFIG_CXL_MEM=m
CONFIG_CXL_FWCTL=y
CONFIG_CXL_PORT=m
CONFIG_CXL_SUSPEND=y
CONFIG_CXL_REGION=y
CONFIG_CXL_REGION_INVALIDATION_TEST=y
CONFIG_CXL_RAS_FEATURES=y
CONFIG_MMC_SDHCI_OF_ARASAN=y
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=m
CONFIG_EDAC_LEGACY_SYSFS=y
CONFIG_EDAC_DEBUG=y
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=m
CONFIG_EDAC_SCRUB=y
CONFIG_EDAC_ECS=y
CONFIG_EDAC_MEM_REPAIR=y
CONFIG_EDAC_IGEN6=m
CONFIG_RAS=y
CONFIG_MEM_ACPI_RAS2=y
CONFIG_DEV_DAX_CXL=m

ld: vmlinux.o: in function `ras2_probe':
/home/fan/cxl/linux-edac/drivers/ras/acpi_ras2.c:363:(.text+0xaeb5c8): undefined reference to `edac_dev_register'
make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
make[1]: *** [/home/fan/cxl/linux-edac/Makefile:1226: vmlinux] Error 2
make: *** [Makefile:251: __sub-make] Error 2

It seems ACPI_RAS2 depends on EDAC.
When changing CONFIG_EDAC=y, it compiles fine.

Fan



> >
> >
> >Fan
> >
> >
> Thanks,
> Shiju

-- 
Fan Ni

