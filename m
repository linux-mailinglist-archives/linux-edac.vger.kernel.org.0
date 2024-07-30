Return-Path: <linux-edac+bounces-1597-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 942C29421F1
	for <lists+linux-edac@lfdr.de>; Tue, 30 Jul 2024 23:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77AE1C229B5
	for <lists+linux-edac@lfdr.de>; Tue, 30 Jul 2024 21:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7F51422D2;
	Tue, 30 Jul 2024 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uf7bRsIg"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EE338B;
	Tue, 30 Jul 2024 21:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722373271; cv=none; b=F/zvCzJ3yTY+nttj8YpvmoJPFrUnPvVm70lbhfkzpbV2zMGIoK4fz3ORujYKS5u89HaxhwZos5OOz6bEcvC6DqyiWMVFb0LO42hszsxXe2Y823bq07IL3kk52h9SePT+XDwWgUMAACFQ5oAxJD6cgw5nibRiCpbHDE2H6qjBMKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722373271; c=relaxed/simple;
	bh=HVyCwim/rNjoYa7Er1mpPod03MkoVlqti8xGdx7XI00=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Az4dQGLe4YNl4BqD4Ou7giGoVDw3XPC61G65DdW+0YGqDYkiVp/JMxylIPgK6+8x6VChp3anT6/CHzVW6PASi+hOOIPJyo8vgVrTEml7EzvdJWdJtghMmC4fuNJdLDAqTXGbchTm81eL9Zfn0xqVlMuck8CLXWAQQfDmowJLBVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uf7bRsIg; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-64f4fd64773so39245787b3.0;
        Tue, 30 Jul 2024 14:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722373267; x=1722978067; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9HEbiK65d0O4x0nutURnHr7ol9LI06hJSM2xxRgUAM8=;
        b=Uf7bRsIguuhUkbl0J3ENOt5/J+KVMYqIwqb4IHvy8FbgY18GQF8ujgfyLW/N6bz/6T
         qX2Uwm8ZfofAks5yCqJg7ajdT08igs762BIpi1m2pEQ+E+mTHLv4xVkF6qSkY+M5URUf
         Hvni+I+jZLEiKdyi1P22zXvvwkwZA4dGtBPkdWvAeO3aa6Sp+68jFWKNMIcv6PR8iDJm
         +NjAgFEF9eKwJnOOBnOc7bmSO17aIgr6LVHH5iwYmQ082xo0u7Rcm9CHY+nfuEo6PApN
         eXfVl9vuFaPcY05NqHkjsDEFTAbXnjnOadYJtAJSsvVjyXImAFs2LZu32c5cRbEfHA3H
         AFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722373267; x=1722978067;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9HEbiK65d0O4x0nutURnHr7ol9LI06hJSM2xxRgUAM8=;
        b=Oq9jiS9cTxH0zm4b9ZzzH4TwxjHSmFeJ3WdSXxzJBTTGlgx6EDY60hBQ8F0+ETulE2
         nuRVo0NRhZoNCc8DDj5GJ3pXTSgCTYJYdFwt0Q5WvueIVe3Ma0/lU+NHLRxxpCenRFle
         kTT9yK9iSsxE96j4CB+pFJO03memT4in7PSTh2GqNoer1pF9CNk904qH27tX3FrmOEip
         Rizs/jpDmfyyZwDQBCxHLAkjejhWKuvyxTWbaEKzAz5QqUJomwRIwgrGhuce1UWd2LwL
         vF9sRLbEwfZXdd5S71p8HbssjnYz3859JLk1+CRSH26xAJHvGCuHXgzWKaXQS/A9VPbm
         JJQA==
X-Forwarded-Encrypted: i=1; AJvYcCXbio+XNdO30ZMtWzWD2mXCN634wOsN5spmTLX/3Okcozc493VBblCuXvR00DY+KW5rMsnPczr/mghQYJ4RpvVOxGUPYd6ebbAI+Aj5NwCRQ2VLcNcAOGSX1mrO0xVnuDGGDhfJ+lxOxYMGTji7T0ozFKJYHbHWzz0oRkgKbqeOnCR74Q==
X-Gm-Message-State: AOJu0Ywe4DbdGDqo9LLXtgpzButk2NSdTmVdb4GGJoKMCKTiZq1NZc0Q
	drT6dTXRIhfLeqx22hEsBarPFfFxe+QI/QKcpFsMc6TJpJLvlca5
X-Google-Smtp-Source: AGHT+IFTfvBkt/NyYd8SkLe2L8jNTtXtVT0UfwgUrJA5EYsRlbeBs4Hpbady5aiaCzmym1J9/3Su1w==
X-Received: by 2002:a0d:f5c7:0:b0:64a:7e85:9a90 with SMTP id 00721157ae682-67a0813b6d8mr144800607b3.24.1722373266967;
        Tue, 30 Jul 2024 14:01:06 -0700 (PDT)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756bab5090sm27001267b3.120.2024.07.30.14.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 14:01:06 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 30 Jul 2024 14:00:55 -0700
To: shiju.jose@huawei.com
Cc: linux-edac@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bp@alien8.de, tony.luck@intel.com,
	rafael@kernel.org, lenb@kernel.org, mchehab@kernel.org,
	dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, david@redhat.com, Vilas.Sridharan@amd.com,
	leo.duran@amd.com, Yazen.Ghannam@amd.com, rientjes@google.com,
	jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
	somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
	duenwen@google.com, mike.malvestuto@intel.com, gthelen@google.com,
	wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH v10 00/11] EDAC: Scrub: introduce generic EDAC RAS
 control feature driver + CXL/ACPI-RAS2 drivers
Message-ID: <ZqlUh4kL0wK5BnnY@debian>
References: <20240726160556.2079-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240726160556.2079-1-shiju.jose@huawei.com>

On Fri, Jul 26, 2024 at 05:05:44PM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
Hi Shiju,
FYI. Not sure if I missed something, but I hit some issue when compiling
the patch set.

I tried to apply this patch set on top of fixes branch (tag:
cxl-fixes-6.10-rc7, origin/fixes), and compile, it fails with following
erors.

fan@DT ~/c/linux-fixes (fixes)> make -j 16
mkdir -p /home/fan/cxl/linux-fixes/tools/objtool && make O=/home/fan/cxl/linux-fixes subdir=tools/objtool --no-print-directory -C objtool
  INSTALL libsubcmd_headers
  CALL    scripts/checksyscalls.sh
  CC      drivers/ras/acpi_ras2.o
drivers/ras/acpi_ras2.c: In function ‘ras2_update_patrol_scrub_params_cache’:
drivers/ras/acpi_ras2.c:64:37: error: implicit declaration of function ‘FIELD_GET’ [-Werror=implicit-function-declaration]
   64 |         ras2_ctx->min_scrub_cycle = FIELD_GET(RAS2_PATROL_SCRUB_MIN_SCHRS_OUT_MASK,
      |                                     ^~~~~~~~~
drivers/ras/acpi_ras2.c: In function ‘ras2_hw_scrub_set_enabled_bg’:
drivers/ras/acpi_ras2.c:216:50: error: implicit declaration of function ‘FIELD_PREP’ [-Werror=implicit-function-declaration]
  216 |                 ps_sm->params.scrub_params_in |= FIELD_PREP(RAS2_PATROL_SCRUB_SCHRS_IN_MASK,
      |                                                  ^~~~~~~~~~
cc1: all warnings being treated as errors
make[4]: *** [scripts/Makefile.build:244: drivers/ras/acpi_ras2.o] Error 1
make[3]: *** [scripts/Makefile.build:485: drivers/ras] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/home/fan/cxl/linux-fixes/Makefile:1934: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2


It seems we need to include "linux/bitfield.h". Fixed the compiling with
following change:

fan@DT ~/c/linux-fixes (fixes)> git diff
diff --git a/drivers/ras/acpi_ras2.c b/drivers/ras/acpi_ras2.c
index b2381d5b37d0..b4d229e6451f 100644
--- a/drivers/ras/acpi_ras2.c
+++ b/drivers/ras/acpi_ras2.c
@@ -11,6 +11,7 @@
 #include <linux/edac_ras_feature.h>
 #include <linux/platform_device.h>
 #include <acpi/ras2_acpi.h>
+#include <linux/bitfield.h>
 
 #define RAS2_DEV_NUM_RAS_FEATURES      1



Fan

> Previously known as "ras: scrub: introduce subsystem + CXL/ACPI-RAS2 drivers".
> 
> EDAC based Subsystem for controlling RAS Features
> =================================================
> The proposed EDAC based subsystem for controlling RAS features and
> expose the feature's control attributes to the userspace in sysfs.
> Some Examples:
>  - Scrub control
>  - Error Check Scrub (ECS) control
>  - ACPI RAS2 features
>  - ACPI Address Range Scrubbing (ARS)
>  - Post Package Repair (PPR) etc.
> 
> High level design is illustrated in the following diagram.
>  
>          _______________________________________________
>         |   Userspace - Rasdaemon                       |
>         |  ____________                                 |
>         | | RAS CXL    |       _____________            | 
>         | | Err Handler|----->|             |           |
>         | |____________|      | RAS Dynamic |           |
>         |  ____________       | Scrub       |           |
>         | | RAS Memory |----->| Controller  |           |
>         | | Err Handler|      |_____________|           |
>         | |____________|           |                    |
>         |__________________________|____________________|                              
>                                    |
>                                    |
>     _______________________________|______________________________
>    |   Kernel EDAC based SubSystem | for RAS Features Control     |
>    | ______________________________|____________________________  |
>    || EDAC Core          Sysfs EDAC| Bus                        | |
>    ||    __________________________|_______     _____________   | |
>    ||   |/sys/bus/edac/devices/<dev>/scrub/|   | EDAC Device |  | |
>    ||   |/sys/bus/edac/devices/<dev>/ecs*/ |<->| EDAC MC     |  | |
>    ||   |/sys/bus/edac/devices/<dev>/ars/  |   | EDAC Sysfs  |  | |
>    ||   |/sys/bus/edac/devices/<dev>/ppr/  |   | EDAC Module |  | |
>    ||   |__________________________________|   |_____________|  | |
>    ||                               | EDAC Bus                  | |
>    ||               Get             |                           | |
>    ||    __________ Feature's       |             __________    | |
>    ||   |          |Descs  _________|______      |          |   | |
>    ||   |EDAC Scrub|<-----|    EDAC RAS    |---->| EDAC ARS |   | |
>    ||   |__________|      |Control Feature |     |__________|   | |
>    ||    __________       |    Driver      |      __________    | |
>    ||   |          |<-----|________________|---->|          |   | |
>    ||   |EDAC ECS  |   Register RAS | Features   | EDAC PPR |   | |
>    ||   |__________|                |            |__________|   | |
>    ||         ______________________|___________________        | |
>    ||_________|_____________|_____________|____________|________| |
>    |   _______|____    _____|______   ____|______   ___|_____     |
>    |  |            |  | CXL Mem   |  |           | |         |    |
>    |  | ACPI RAS2  |  | Driver    |  | ACPI ARS  | | PPR     |    |
>    |  | Driver     |  | Scrub,ECS |  | Driver    | | Driver  |    |
>    |  |____________|  |___________|  |___________| |_________|    |
>    |        |              |              |           |           |
>    |________|______________|______________|___________|___________|
>             |              |              |           |          
>      _______|______________|______________|___________|___________
>     |     __|______________|_ ____________|___________|_____      |
>     |    |                                                  |     |
>     |    |            Platform HW and Firmware              |     |
>     |    |__________________________________________________|     |
>     |_____________________________________________________________|                             
> 
> 1. EDAC Features components - Create feature specific descriptors.
> 2. EDAC RAS Feature driver - Get feature's attr descriptors from the 
>    EDAC RAS feature component and registers device's RAS features with
>    EDAC bus and expose the feature's sysfs attributes under the sysfs
>    EDAC bus.
> 3. RAS dynamic scrub controller - Userspace sample module added in the
>    rasdaemon to start scrubbing when excess number of related errors
>    are reported in a short span of time.
> 
> The added EDAC feature specific components (e.g. EDAC scrub, EDAC ECS,
> EDAC PPR etc) do callbacks to  the parent driver (e.g. CXL driver,
> ACPI RAS driver etc) for the controls rather than just letting the
> caller deal with it because of the following reasons.
> 1. Enforces a common API across multiple implementations can do that
>    via review, but that's not generally gone well in the long run for
>    subsystems that have done it (several have later moved to callback
>    and feature list based approaches).
> 2. Gives a path for 'intercepting' in the EDAC feature driver.
>    An example for this is that we could intercept PPR repair calls
>    and sanity check that the memory in question is offline before
>    passing back to the underlying code.  Sure we could rely on doing
>    that via some additional calls from the parent driver, but the
>    ABI will get messier.
> 3. (Speculative) we may get in kernel users of some features in the
>    long run.
> 
> More details of the common RAS features are described in the following
> sections.
> 
> Memory Scrubbing
> ================
> Increasing DRAM size and cost has made memory subsystem reliability
> an important concern. These modules are used where potentially
> corrupted data could cause expensive or fatal issues. Memory errors are
> one of the top hardware failures that cause server and workload crashes.
> 
> Memory scrub is a feature where an ECC engine reads data from
> each memory media location, corrects with an ECC if necessary and
> writes the corrected data back to the same memory media location.
> 
> The memory DIMMs could be scrubbed at a configurable rate to detect
> uncorrected memory errors and attempts to recover from detected memory
> errors providing the following benefits.
> - Proactively scrubbing memory DIMMs reduces the chance of a correctable
>   error becoming uncorrectable.
> - Once detected, uncorrected errors caught in unallocated memory pages are
>   isolated and prevented from being allocated to an application or the OS.
> - The probability of software/hardware products encountering memory
>   errors is reduced.
> Some details of background can be found in Reference [5].
> 
> There are 2 types of memory scrubbing,
> 1. Background (patrol) scrubbing of the RAM whilest the RAM is otherwise
>    idle.
> 2. On-demand scrubbing for a specific address range/region of memory.
> 
> There are several types of interfaces to HW memory scrubbers
> identified such as ACPI NVDIMM ARS(Address Range Scrub), CXL memory
> device patrol scrub, CXL DDR5 ECS, ACPI RAS2 memory scrubbing.
> 
> The scrub control varies between different memory scrubbers. To allow
> for standard userspace tooling there is a need to present these controls
> with a standard ABI.
> 
> Introduce generic memory EDAC scrub control which allows user to
> control underlying scrubbers in the system via generic sysfs scrub
> control interface.
> 
> Use case of common scrub control feature
> ========================================
> 1. There are several types of interfaces to HW memory scrubbers identified
>    such as ACPI NVDIMM ARS(Address Range Scrub), CXL memory device patrol
>    scrub, CXL DDR5 ECS, ACPI RAS2 memory scrubbing features and software
>    based memory scrubber(discussed in the community Reference [5]).
>    Also some scrubbers support controlling (background) patrol scrubbing
>    (ACPI RAS2, CXL) and/or on-demand scrubbing(ACPI RAS2, ACPI ARS).
>    However the scrub controls varies between memory scrubbers. Thus there
>    is a requirement for a standard generic sysfs scrub controls exposed
>    to the userspace for the seamless control of the HW/SW scrubbers in
>    the system by admin/scripts/tools etc.
> 2. Scrub controls in user space allow the user to disable the scrubbing
>    in case disabling of the background patrol scrubbing or changing the
>    scrub rate are needed for other purposes such as performance-aware
>    operations which requires the background operations to be turned off
>    or reduced.
> 3. Allows to perform on-demand scrubbing for specific address range if
>    supported by the scrubber.
> 4. User space tools controls scrub the memory DIMMs regularly at a
>    configurable scrub rate using the sysfs scrub controls discussed help,
>    - to detect uncorrectable memory errors early before user accessing memory,
>      which helps to recover the detected memory errors.
>    - reduces the chance of a correctable error becoming uncorrectable.
> 5. Policy control for hotplugged memory. There is not necessarily a system
>    wide bios or similar in the loop to control the scrub settings on a CXL
>    device that wasn't there at boot. What that setting should be is a policy
>    decision as we are trading of reliability vs performance - hence it should
>    be in control of userspace. As such, 'an' interface is needed. Seems more
>    sensible to try and unify it with other similar interfaces than spin
>    yet another one.
> 
> The draft version of userspace code for dynamic scrub control, based
> on frequency of memory errors reported to the userspace, is added in
> rasdaemon and enabled, tested for CXL device based patrol scrubbing feature
> and ACPI RAS2 based scrubbing feature.
> 
> https://github.com/shijujose4/rasdaemon/tree/scrub_control_6_june_2024
> 
> Comparison of scrubbing features
> ================================
>  ................................................................
>  .              .   ACPI    . CXL patrol.  CXL ECS  .  ARS      .
>  .  Name        .   RAS2    . scrub     .           .           .
>  ................................................................
>  .              .           .           .           .           .
>  . On-demand    . Supported . No        . No        . Supported .
>  . Scrubbing    .           .           .           .           .
>  .              .           .           .           .           .  
>  ................................................................
>  .              .           .           .           .           .
>  . Background   . Supported . Supported . Supported . No        .
>  . scrubbing    .           .           .           .           .
>  .              .           .           .           .           .
>  ................................................................
>  .              .           .           .           .           .
>  . Mode of      . Scrub ctrl. per device. per memory.  Unknown  .
>  . scrubbing    . per NUMA  .           . media     .           .
>  .              . domain.   .           .           .           .
>  ................................................................
>  .              .           .           .           .           . 
>  . Query scrub  . Supported . Supported . Supported . Supported .       
>  . capabilities .           .           .           .           .
>  .              .           .           .           .           .
>  ................................................................
>  .              .           .           .           .           . 
>  . Setting      . Supported . No        . No        . Supported .       
>  . address range.           .           .           .           .
>  .              .           .           .           .           .
>  ................................................................
>  .              .           .           .           .           . 
>  . Setting      . Supported . Supported . No        . No        .       
>  . scrub rate   .           .           .           .           .
>  .              .           .           .           .           .
>  ................................................................
>  .              .           .           .           .           . 
>  . Unit for     . Not       . in hours  . No        . No        .       
>  . scrub rate   . Defined   .           .           .           .
>  .              .           .           .           .           .
>  ................................................................
>  .              . Supported .           .           .           .
>  . Scrub        . on-demand . No        . No        . Supported .
>  . status/      . scrubbing .           .           .           .
>  . Completion   . only      .           .           .           .
>  ................................................................
>  . UC error     .           .CXL general.CXL general. ACPI UCE  .
>  . reporting    . Exception .media/DRAM .media/DRAM . notify and.
>  .              .           .event/media.event/media. query     .
>  .              .           .scan?      .scan?      . ARS status.
>  ................................................................
>  .              .           .           .           .           .      
>  . Clear UC     .  No       . No        .  No       . Supported .
>  . error        .           .           .           .           .
>  .              .           .           .           .           .  
>  ................................................................
>  .              .           .           .           .           .
>  . Translate    . No        . No        . No        . Supported .
>  . *(1)SPA to   .           .           .           .           .
>  . *(2)DPA      .           .           .           .           .  
>  ................................................................
>  .              .           .           .           .           .
>  . Error inject . No        . Can inject. No        . Supported .
>  .              .           . poison for.           .           .
>  .              .           . CXL       .           .           .  
>  ................................................................
> *(1) - SPA - System Physical Address. See section 9.19.7.8
>        Function Index 5 - Translate SPA of ACPI spec r6.5.  
> *(2) - DPA - Device Physical Address. See section 9.19.7.8
>        Function Index 5 - Translate SPA of ACPI spec r6.5.  
> 
> CXL Scrubbing features
> ======================
> Add support for control CXL patrol scrubber and ACPI RAS2 HW based memory
> patrol scrubber and register with the EDAC scrub to expose the scrub
> controls to the userspace tool.
> 
> CXL spec r3.1 section 8.2.9.9.11.1 describes the memory device patrol scrub
> control feature. The device patrol scrub proactively locates and makes
> corrections to errors in regular cycle. The patrol scrub control allows the
> request to configure patrol scrubber's input configurations.
> 
> The patrol scrub control allows the requester to specify the number of
> hours in which the patrol scrub cycles must be completed, provided that
> the requested number is not less than the minimum number of hours for the
> patrol scrub cycle that the device is capable of. In addition, the patrol
> scrub controls allow the host to disable and enable the feature in case
> disabling of the feature is needed for other purposes such as
> performance-aware operations which require the background operations to be
> turned off.
> 
> The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
> Specification (JESD79-5) and allows the DRAM to internally read, correct
> single-bit errors, and write back corrected data bits to the DRAM array
> while providing transparency to error counts.
> 
> The DDR5 device contains number of memory media FRUs per device. The
> DDR5 ECS feature and thus the ECS control driver supports configuring
> the ECS parameters per FRU.
> 
> ACPI RAS2 Hardware-based Memory Scrubbing
> =========================================
> ACPI spec 6.5 section 5.2.21 ACPI RAS2 describes ACPI RAS2 table
> provides interfaces for platform RAS features and supports independent
> RAS controls and capabilities for a given RAS feature for multiple
> instances of the same component in a given system.
> Memory RAS features apply to RAS capabilities, controls and operations
> that are specific to memory. RAS2 PCC sub-spaces for memory-specific RAS
> features have a Feature Type of 0x00 (Memory).
> 
> The platform can use the hardware-based memory scrubbing feature to expose
> controls and capabilities associated with hardware-based memory scrub
> engines. The RAS2 memory scrubbing feature supports following as per spec,
>  - Independent memory scrubbing controls for each NUMA domain, identified
>    using its proximity domain.
>    Note: However AmpereComputing has single entry repeated as they have
>          centralized controls.
>  - Provision for background (patrol) scrubbing of the entire memory system,
>    as well as on-demand scrubbing for a specific region of memory.
> 
> ACPI Address Range Scrubbing(ARS)
> ================================
> ARS allows the platform to communicate memory errors to system software.
> This capability allows system software to prevent accesses to addresses
> with uncorrectable errors in memory. ARS functions manage all NVDIMMs
> present in the system. Only one scrub can be in progress system wide
> at any given time.
> Following functions are supported as per the specification.
> 1. Query ARS Capabilities for a given address range, indicates platform
>    supports the ACPI NVDIMM Root Device Unconsumed Error Notification.
> 2. Start ARS triggers an Address Range Scrub for the given memory range.
>    Address scrubbing can be done for volatile memory, persistent memory,
>    or both.
> 3. Query ARS Status command allows software to get the status of ARS,  
>    including the progress of ARS and ARS error record.
> 4. Clear Uncorrectable Error.
> 5. Translate SPA
> 6. ARS Error Inject etc.
> Note: Support for ARS is not added in this series because to reduce the
> line of code for review and could be added after initial code is merged. 
> We'd like feedback on whether this is of interest to ARS community?
> 
> Series adds,
> 1. Generic EDAC RAS feature driver, EDAC scrub driver, EDAC ECS driver
>    supports memory scrub control, ECS control and other RAS features
>    in the system.
> 2. Support for CXL feature mailbox commands, which is used by
>    CXL device scrubbing features. 
> 3. CXL scrub driver supporting patrol scrub control (device and
>    region based).
> 4. CXL ECS driver supporting ECS control feature.
> 5. ACPI RAS2 driver adds OS interface for RAS2 communication through
>    PCC mailbox and extracts ACPI RAS2 feature table (RAS2) and
>    create platform device for the RAS memory features, which binds
>    to the memory ACPI RAS2 driver.
> 7. Memory ACPI RAS2 driver gets the PCC subspace for communicating
>    with the ACPI compliant platform supports ACPI RAS2. Add callback
>    functions and registers with EDAC scrub to support user to
>    control the HW patrol scrubbers exposed to the kernel via the
>    ACPI RAS2 table.
> 
> The CXL specific scrub and ECS features are supported in
> https://gitlab.com/qemu-project/qemu.git
> 
> Open Questions based on feedbacks from the community:
> 1. Leo: Standardize unit for scrub rate, for example ACPI RAS2 does not define
>    unit for the scrub rate. RAS2 clarification needed. 
> 2. Jonathan: Any need for discoverability of capability to scan different regions,
>    such as global PA space to the userspace. Left as future extension.
> 3. Jiaqi:
>    - STOP_PATROL_SCRUBBER from RAS2 must be blocked and, must not be exposed to
>      OS/userspace. Stopping patrol scrubber is unacceptable for platform where
>      OEM has enabled patrol scrubber, because the patrol scrubber is a key part
>      of logging and is repurposed for other RAS actions.
>    If the OEM does not want to expose this control, they should lock it down so the
>    interface is not exposed to the OS. These features are optional afterall.
>    - "Requested Address Range"/"Actual Address Range" (region to scrub) is a
>       similarly bad thing to expose in RAS2.
>    If the OEM does not want to expose this, they should lock it down so the
>    interface is not exposed to the OS. These features are optional afterall.
> 4. Borislav: 
>    - How the scrub control exposed to the userspace will be used?
>      POC added in rasdaemon with dynamic scrub control for CXL memory media
>      errors and memory errors reported to the userspace.
>      https://github.com/shijujose4/rasdaemon/tree/scrub_control_6_june_2024
>    - Is the scrub interface is sufficient for the use cases?
>    - Who is going to use scrub controls tools/admin/scripts?
>      1) Rasdaemon for dynamic control
>      2) Udev script for more static 'defaults' on hotplug etc.
> 
> References:
> 1. ACPI spec r6.5 section 5.2.21 ACPI RAS2.
> 2. ACPI spec r6.5 section 9.19.7.2 ARS.
> 3. CXL spec  r3.1 8.2.9.9.11.1 Device patrol scrub control feature
> 4. CXL spec  r3.1 8.2.9.9.11.2 DDR5 ECS feature
> 5. Background information about kernel support for memory scan, memory
>    error detection and ACPI RASF.
>    https://lore.kernel.org/all/20221103155029.2451105-1-jiaqiyan@google.com/
> 6. Discussions on RASF:
>    https://lore.kernel.org/lkml/20230915172818.761-1-shiju.jose@huawei.com/#r 
> 
> Changes
> =======
> v9 -> v10:
> 1. Feedback from Mauro Carvalho Chehab:
>    - Changes suggested in EDAC RAS feature driver.
>      use uppercase for enums, if else to switch-case, documentation for
>      static scrub and ecs init functions etc.
>    - Changes suggested in EDAC scrub.
>      unit of scrub cycle hour to seconds.
>      attribute node cycle_in_hours_avaiable to min_cycle_duration and 
>      max_cycle_duration.
>      attribute node cycle_in_hours to current_cycle_duration.
>      Use base 0 for kstrtou64() and kstrtol() functions.
>      etc.
>    - Changes suggested in EDAC ECS.
>      uppercase for enums
>      add ABI documentation. etc
>         
> 2. Feedback from Fan:
>    - Changes suggested in EDAC RAS feature driver.
>      use uppercase for enums, change if...else to switch-case. 
>      some optimization in edac_ras_dev_register() function
>      add missing goto free_ctx
>    - Changes suggested in the code for feature commands.  
>    - CXL driver scrub and ECS code
>      use uppercase for enums, fix typo, use enum type for mode
>      fix lonf lines etc.
>        
> v8 -> v9:
> 1. Feedback from Borislav:
>    - Add scrub control driver to the EDAC on feedback from Borislav.
>    - Changed DEVICE_ATTR_..() static.
>    - Changed the write permissions for scrub control sysfs files as
>      root-only.
> 2. Feedback from Fan:
>    - Optimized cxl_get_feature() function by using min() and removed
>      feat_out_min_size.
>    - Removed unreached return from cxl_set_feature() function.
>    - Changed the term  "rate" to "cycle_in_hours" in all the
>      scrub control code.
>    - Allow cxl_mem_probe() continue if cxl_mem_patrol_scrub_init() fail,
>      with just a debug warning.
>       
> 3. Feedback from Jonathan:
>    - Removed patch __free() based cleanup function for acpi_put_table.
>      and added fix in the acpi ras2 driver.
> 
> 4. Feedback from Dan Williams:
>    - Allow cxl_mem_probe() continue if cxl_mem_patrol_scrub_init() fail,
>      with just a debug warning.
>    - Add support for CXL region based scrub control.
> 
> 5. Feedback from Daniel Ferguson on RAS2 drivers:
>     In the ACPI RAS2 driver,
>   - Incorporated the changes given for clearing error reported.
>   - Incorporated the changes given for check the Set RAS Capability
>     status and return an appropriate error.
>     In the RAS2 memory driver,
>   - Added more checks for start/stop bg and on-demand scrubbing
>     so that addr range in cache do not get cleared and restrict
>     permitted operations during scrubbing.
> 
> v7 -> v8:
> 1. Add more detailed cover letter and add info for basic analysis
>    of ACPI ARS for comment from Dan Williams.
> 2. Changed file name etc from ras2 to acpi_ras2 in memory ACPI RAS2
>    driver for comment from Boris.
> 3. Add documents for usage for comment from Jonathan.
> 4. Changed logic in memory/acpi_ras2.c for enable background
>    scrubbing to allow setting the scrub rate.
> 5. Merged memory/acpi_ras2_common.c with memory/acpi_ras2.c and
>    obselete code, suggested by Jonathan.  
> 6. Initial optimizations and cleanup especially in the memory/acpi_ras2.
> 7. Removed CXL ECS support for time being. 
> 8. Removed support for region based scrub control from the scrub
>    subsytem, which was needed for the CXL ECS, can be added later
>    if required.
> 9. Fixed the format of few comments and a definition in CXL feature
>     code for the feedbacks from Fan.
> 11. Jonathan done several optimizations, interface changes and
>     cleanups all over the code.
> 12. Fixes for feedbacks from Daniel Ferguson(Amperecomputing)
>     for RAS2.
> 13.  Workaround for a RAS2 case of only one actual controller as
>      reported by Daniel Ferguson(AmpereComputing) in their hardware.
> 14. Feedback from Yazen, move the common scrub and ras2 changes
>     under /drivers/ras/.
> 15. Drop patch ACPICA: ACPI 6.5: Add support for RAS2 table because 
>     Rafael queued the patch.
>     https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=9726d821f88e284ecd998b76ae5f2174721cd9dc
>  
> v6 -> v7:
> 1. Main changes for comments from Jonathan, Thanks.
> 1.1. CXL
>  - Changes for deal with small mail box and supporting multipart
>    feature data transfers.
>  - Provide more specific parameters to mbox supported/get/set features
>    interface functions.
>  - kvmalloc -> kmalloc in CXL scrub mem allocation for feature commands.
>  - Changed the way using __free(kfree)
>  - Removed readback and verify for setting CXL scrub patrol and ECS
>    parameters. Could be added later if needed.
>  - In is_visible() callback functions for scrub control sysfs attrs
>    changed to writeback the default attribute mode value instead of
>    setting per attrs.
>  - Add documentation for sysfs interfaces for CXL ECS scrub control. 
> 1.2. RAS2
>  - In rasf common code, rename rasf to ras2 because RASF seems obselete.
>  - Replace pr_* with dev_* log function calls from ACPI RAS2 and
>    memory RAS2 drivers.
>  - In rasf common code, rename rasf to ras2.
>  - Removed including unnecessary .h file from memory RAS2 driver.
>  - In is_visible() callback functions for scrub control sysfs attrs
>    changed to writeback the default attribute mode value instead of
>    setting per attribute.
> 
> 2. Changes for comments from Fan, Thanks.
>  - Add debug message if cxl patrol scrub and ecs init function
>    calls fail.
> 3. Updated cover letter for feedback from Dan Williams. 
>    
> v5 -> v6:
> 1. Changes for comments from Davidlohr, Thanks.
>  - Update CXL feature code based on spec 3.1.
>  - attrb -> attr
>  - Use enums with default counting.  
> 2. Rebased to the latest kernel.
> 
> v4 -> v5:
> 1. Following are the main changes made based on the feedback from Dan Williams on v4.
> 1.1. In the scrub subsystem the common scrub control attributes are statically defined
>      instead of dynamically created.
> 1.2. Add scrub subsystem support externally defined attribute group.
>      Add CXL ECS driver define ECS specific attribute group and pass to
> 	 the scrub subsystem.
> 1.3. Move cxl_mem_ecs_init() to cxl/core/region.c so that the CXL region_id
>      is used in the registration with the scrub subsystem. 	 
> 1.4. Add previously posted RASF common and RAS2 patches to this scrub series.
> 	 
> 2. Add support for the 'enable_background_scrub' attribute
>    for RAS2, on request from Bill Schwartz(wschwartz@amperecomputing.com).
> 
> v3 -> v4:
> 1. Fixes for the warnings/errors reported by kernel test robot.
> 2. Add support for reading the 'enable' attribute of CXL patrol scrub.
> 
> Changes
> v2 -> v3:
> 1. Changes for comments from Davidlohr, Thanks.
>  - Updated cxl scrub kconfig
>  - removed usage of the flag is_support_feature from
>    the function cxl_mem_get_supported_feature_entry().
>  - corrected spelling error.
>  - removed unnecessary debug message.
>  - removed export feature commands to the userspace.
> 2. Possible fix for the warnings/errors reported by kernel
>    test robot.
> 3. Add documentation for the common scrub configure attributes.
> 
> v1 -> v2:
> 1. Changes for comments from Dave Jiang, Thanks.
>  - Split patches.
>  - reversed xmas tree declarations.
>  - declared flags as enums.
>  - removed few unnecessary variable initializations.
>  - replaced PTR_ERR_OR_ZERO() with IS_ERR() and PTR_ERR().
>  - add auto clean declarations.
>  - replaced while loop with for loop.
>  - Removed allocation from cxl_get_supported_features() and
>    cxl_get_feature() and make change to take allocated memory
>    pointer from the caller.
>  - replaced if/else with switch case.
>  - replaced sprintf() with sysfs_emit() in 2 places.
>  - replaced goto label with return in few functions.
> 2. removed unused code for supported attributes from ecs.
> 3. Included following common patch for scrub configure driver
>    to this series.
>    "memory: scrub: Add scrub driver supports configuring memory scrubbers
>     in the system"
> 
> 
> Jonathan Cameron (1):
>   platform: Add __free() based cleanup function for platform_device_put
> 
> Shiju Jose (10):
>   EDAC: Add generic EDAC RAS control feature driver
>   EDAC: Add EDAC scrub control driver
>   EDAC: Add EDAC ECS control driver
>   cxl/mbox: Add GET_SUPPORTED_FEATURES mailbox command
>   cxl/mbox: Add GET_FEATURE mailbox command
>   cxl/mbox: Add SET_FEATURE mailbox command
>   cxl/memscrub: Add CXL memory device patrol scrub control feature
>   cxl/memscrub: Add CXL memory device ECS control feature
>   ACPI:RAS2: Add ACPI RAS2 driver
>   ras: scrub: ACPI RAS2: Add memory ACPI RAS2 driver
> 
>  Documentation/ABI/testing/sysfs-edac-ecs   |  85 ++
>  Documentation/ABI/testing/sysfs-edac-scrub |  76 ++
>  Documentation/scrub/edac-scrub.rst         | 115 +++
>  drivers/acpi/Kconfig                       |  10 +
>  drivers/acpi/Makefile                      |   1 +
>  drivers/acpi/ras2.c                        | 391 +++++++++
>  drivers/cxl/Kconfig                        |  19 +
>  drivers/cxl/core/Makefile                  |   1 +
>  drivers/cxl/core/mbox.c                    | 139 ++++
>  drivers/cxl/core/memscrub.c                | 873 +++++++++++++++++++++
>  drivers/cxl/core/region.c                  |   6 +
>  drivers/cxl/cxlmem.h                       | 129 +++
>  drivers/cxl/mem.c                          |   4 +
>  drivers/edac/Makefile                      |   1 +
>  drivers/edac/edac_ecs.c                    | 396 ++++++++++
>  drivers/edac/edac_ras_feature.c            | 187 +++++
>  drivers/edac/edac_scrub.c                  | 333 ++++++++
>  drivers/ras/Kconfig                        |  10 +
>  drivers/ras/Makefile                       |   1 +
>  drivers/ras/acpi_ras2.c                    | 415 ++++++++++
>  include/acpi/ras2_acpi.h                   |  59 ++
>  include/linux/edac_ras_feature.h           | 132 ++++
>  include/linux/platform_device.h            |   1 +
>  23 files changed, 3384 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-edac-ecs
>  create mode 100644 Documentation/ABI/testing/sysfs-edac-scrub
>  create mode 100644 Documentation/scrub/edac-scrub.rst
>  create mode 100755 drivers/acpi/ras2.c
>  create mode 100644 drivers/cxl/core/memscrub.c
>  create mode 100755 drivers/edac/edac_ecs.c
>  create mode 100755 drivers/edac/edac_ras_feature.c
>  create mode 100755 drivers/edac/edac_scrub.c
>  create mode 100644 drivers/ras/acpi_ras2.c
>  create mode 100644 include/acpi/ras2_acpi.h
>  create mode 100755 include/linux/edac_ras_feature.h
> 
> -- 
> 2.34.1
> 

