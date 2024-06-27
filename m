Return-Path: <linux-edac+bounces-1403-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B5E91AE11
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 19:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7C31C22368
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 17:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1878E19A287;
	Thu, 27 Jun 2024 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwKYsLT+"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184B41865A;
	Thu, 27 Jun 2024 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509583; cv=none; b=pd92MzfGeCezpe3dDq81AxscD/LPhfilob3gqgNCnJfpP8j8ubpdjtII4bnJQ/Z6lVedth8ctbJ7201Q+ixpFazeMTjTSYrsS5ZrRl8sSM3axigi8K6+ksfa+J8hvOtMrG7eSqbn8bVxpI3KUFw6fPQVtra/ahstFtvIEeJ7Sps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509583; c=relaxed/simple;
	bh=SIdFKMNV0sEQoe8SWXcyAkQIxLMaXDMqlZlW14wZl2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sIxPC2+MSk5iyo2GgzmRaXxLkvvtsj3P9iU/ui/P0Oy+/by3i7DEHlQIEkN+aLMThvAODiOrNfh655dR6tw/HPVojA4/mcD6mSK4aqTcShuaUxU1Rpsylj/pFvxagKbSCqrVKKNQWseoO5IkFzDriJ4ZGLv6dy/1m0W1ZF5zhAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwKYsLT+; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52ce6c93103so6321215e87.3;
        Thu, 27 Jun 2024 10:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719509579; x=1720114379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8XCB5YqkGEtK4iaAJi8X5eEARY9rC+3u0N9QWWLXY6A=;
        b=MwKYsLT+AnwPSF+oyCmx0phTiGdOtpIrnwt6sc3Cp6I4duoS5FLVAxhNlH4IhkNKre
         NXsUq/5D60PE6SsKmk8RoQo7i+kpiQYkHOtm4+g2LOWKutp9gWGSveZaWo7V0jIwuEhR
         ZyqAfEpUO7vDl1S5BFmudqeWVIxDSdZUgGM2JkOkFa1UCBcSMwGOdNC7SUbHLXzhzx/t
         bR0SxGi9A8pIUFVqvkqqm7UFVsw1ViwBqqIubzi3pU70U07hh/PVCKoTTCyCMxeawYMA
         rlJhQT3aX4zxzKOVmXwGCmPGftNeaUpCliShdjtWfxCXhfFAHLRxosnh1SVh+I+jRu4v
         piEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719509579; x=1720114379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XCB5YqkGEtK4iaAJi8X5eEARY9rC+3u0N9QWWLXY6A=;
        b=vtnQLZFHqMVUhe4h4oXny5Or7IQehofs/6dcCY9Z9h9g2TpW4RyRsa1PPT6j2HBwuz
         9/isuHL/TFDRWMJsp68TtaFPrEtN1Q4ocPVk0yTcAyhcIDXNlAufogB1BJUT9EJw6oP0
         qOQUuMvobut18gIXVmOCCr0L9kLq3n1HW9TegNiDZVRpESu1z+n19oW+Klb/v1+KmxZ4
         DbBqyxzkgqDFBl5UQ33PzP4EAHQH3JlQcP0gfxwQ0/VeJi3xenno76kb0Wf9zeSBXu2l
         Fo+sgPOZS/aB87yCbzKFOy3RNzSHoWnsCxyybBBAtCCNINk1Qz8PKUkHqMqzsKAbhCpY
         CE3w==
X-Forwarded-Encrypted: i=1; AJvYcCVuw/kWVvQAziP4j8skFXs91tcMYUabbF5vGEvRhhlu3POnfs750d3h8PtJXx73CNoO8QDmt496Iijvby8Yuf4yZYWqGhj8kak4oNuP5dSkQdAL5eLlJ1A1c3NjG+rjAJnBPwRTSCepkQ==
X-Gm-Message-State: AOJu0YwlcctfBHxEjTMLqmDH3lyVY2ucPfie5JOszTHwQizyYGiuyKt+
	ouQSWwmQTAlx/nYxGt4fKVEz4VvnfdSIQkchqhNwA6Ls5aMLj+BX
X-Google-Smtp-Source: AGHT+IGVmZXVUlOlkEUTUOwuxQMp87hD6qmRM6RGDTTQwwXm5HRzyqMO8TUarcB+rtI/C2rheYOYog==
X-Received: by 2002:a05:6512:ac8:b0:52d:582e:4111 with SMTP id 2adb3069b0e04-52d582e41d9mr7690031e87.18.1719509578973;
        Thu, 27 Jun 2024 10:32:58 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e713204cesm270486e87.245.2024.06.27.10.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:32:58 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v6 00/18] EDAC/mc/synopsys: Various fixes and cleanups
Date: Thu, 27 Jun 2024 20:32:07 +0300
Message-ID: <20240627173251.25718-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset is a first one in the series created in the framework of
my Synopsys DW uMCTL2 DDRC-related work:

[1: In-progress v6] EDAC/mc/synopsys: Various fixes and cleanups
Link: ---you are looking at it---
[2: In-progress v4] EDAC/synopsys: Add generic DDRC info and address mapping
Link: https://lore.kernel.org/linux-edac/20230920192806.29960-1-fancer.lancer@gmail.com
[3: In-progress v4] EDAC/synopsys: Add generic resources and Scrub support
Link: https://lore.kernel.org/linux-edac/20230920195720.32047-1-fancer.lancer@gmail.com

Note the patchsets above must be merged in the same order as they are
placed in the list in order to prevent conflicts. Nothing prevents them
from being reviewed synchronously though. Any tests are very welcome.
Thanks in advance.

The main goal of the entire set of the changes provided in the mentioned
patchsets is to as much as possible specialise the synopsys_edac.c driver
to be working with the Synopsys DW uMCTL2 DDR controllers of various
versions and synthesized parameters, and add useful error-detection
features.

Regarding this series content. It's an initial patchset which
traditionally provides various fixes, cleanups and modifications required
for the more comfortable further features development. The main goal of it
though is to detach the Xilinx Zynq A05 DDRC related code into the
dedicated driver since first it has nothing to do with the Synopsys DW
uMCTL2 DDR controller and second it will be a great deal obstacle on the
way of extending the Synopsys-part functionality.

The series starts with the fixes patches, which in short concern the next
aspects: touching the ZynqMP-specific CSRs on the Xilinx ZinqMP platform
only, serializing an access to the ECCCLR/ECCCTL register, adding correct memory
devices type detection, setting a correct value to the
mem_ctl_info.scrub_cap field, dropping an erroneous ADDRMAP[4] parsing and
getting back a correct order of the ECC errors info detection procedure.

Afterwards the patchset provides several cleanup patches required for the
more coherent code splitting up (Xilinx Zynq A05 and Synopsys DW uMCTL2
DDRCs) so the provided modifications would be useful in both drivers.
First of all the next redundant entities are dropped: internal
CE/UE errors counters, local to_mci() macros definition, some redundant
ecc_error_info structure fields and redundant info from the error message,
duplicated dimm->nr_pages debug printout and spaces from the MEM_TYPE
flags declarations. (The later two updates concern the MCI core part.)
Secondly before detaching the Zynq A05-related code an unique MC index
allocation infrastructure is added to the MCI core. It's required since
after splitting the driver up both supported types of memory devices could
be correctly probed on the same platform. Note even though it's currently
unsupported by the synsopsys_edac.c driver it's claimed to be possible by
the original driver author (it was a reason of having two unrelated
devices supported in a single driver). Finally the Xilinx Zynq A05 part of
the driver is moved out to a dedicated driver. After that the
platform-specific setups API is removed from the Synopsys DW uMCTL2 DDRC
driver since it's no longer required.

Finally as the cherry on the cake a set of the local coding style
cleanups are provided: unify the DW uMCTL2 DDRC driver entities naming and
replace the open-coded "shift/mask" pattern with the kernel helpers like
BIT/GENMASK/FIELD_x in there. It shall significantly improve the code
readability.

Changelog v2:
- Move Synopsys DW uMCTL2 DDRC bindings file renaming to a separate patch.
  (@Krzysztof)
- Introduce a new compatible string "snps,dw-umctl2-ddrc" matching the new
  DT-schema name.
- Forgot to fix some of the prefix of the SYNPS_ZYNQMP_IRQ_REGS macro
  in several places. (@tbot)
- Drop the no longer used "priv" pointer from the mc_init() function.
  (@tbot)
- Include "linux/bitfield.h" header file to get the FIELD_GET macro
  definition. (@tbot)
- Drop the already merged in patches:
[PATCH 12/20] EDAC/mc: Replace spaces with tabs in memtype flags definition
[PATCH 13/20] EDAC/mc: Drop duplicated dimm->nr_pages debug printout

Changelog v3:
- Drop the no longer used "priv" pointer from the mc_init() function.
  (@tbot)
- Drop the merged in patches:
[PATCH v2 14/19] dt-bindings: memory: snps: Detach Zynq DDRC controller support
[PATCH v2 15/19] dt-bindings: memory: snps: Use more descriptive device name
  (@Krzysztof)

Changelog v4:
- Remove Rob, Krzysztof and DT-mailing list from Cc since the respective
  patches have already been merged in.
- Add a new patch
  [PATCH v4 6/20] EDAC/synopsys: Fix misleading IRQ self-cleared quirk flag
  detached from the very first patch of the series.
- Add a new patch
  [PATCH v4 15/20] EDAC/mc: Re-use generic unique MC index allocation procedure
- Add a new patch
  [PATCH v4 18/20] EDAC/synopsys: Unify CSRs macro declarations
  collecting the changes from various patches of the series.
- Drop redundant empty lines left by mistake.
- Drop private counters access from the check_errors() method too.
- Rebase onto the kernel v6.6-rcX.

Link: https://lore.kernel.org/linux-edac/20230920191059.28395-1-fancer.lancer@gmail.com
Changelog v5:
- Fix function names in the zynq_edac.c kdoc.
- Rebase onto the kernel 6.8-rc3.

Link: https://lore.kernel.org/linux-edac/20240222181324.28242-1-fancer.lancer@gmail.com/
Changelog v6:
- Drop the patch with the already applied content:
  [PATCH v5 01/20] EDAC/synopsys: Fix ECC status data and IRQ disable race condition
  [PATCH v5 07/20] EDAC/synopsys: Use platform device devm ioremap method
- Minor commit log changes.
- Rebase onto the kernel 6.10-rc4 and just resend.

base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Cc: Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (18):
  EDAC/synopsys: Fix generic device type detection procedure
  EDAC/synopsys: Fix mci->scrub_cap field setting
  EDAC/synopsys: Drop erroneous ADDRMAP4.addrmap_col_b10 parse
  EDAC/synopsys: Fix reading errors count before ECC status
  EDAC/synopsys: Fix misleading IRQ self-cleared quirk flag
  EDAC/synopsys: Drop internal CE and UE counters
  EDAC/synopsys: Drop local to_mci() macro definition
  EDAC/synopsys: Drop struct ecc_error_info.blknr field
  EDAC/synopsys: Shorten out struct ecc_error_info.bankgrpnr field name
  EDAC/synopsys: Drop redundant info from the error messages
  EDAC/mc: Init DIMM labels in MC registration method
  EDAC/mc: Add generic unique MC index allocation procedure
  EDAC/mc: Re-use generic unique MC index allocation procedure
  EDAC/synopsys: Detach Zynq A05 DDRC support to separate driver
  EDAC/synopsys: Drop unused platform-specific setup API
  EDAC/synopsys: Unify CSRs macro declarations
  EDAC/synopsys: Unify struct/macro/function prefixes
  EDAC/synopsys: Convert to using BIT/GENMASK/FIELD_x macros

 MAINTAINERS                  |   1 +
 drivers/edac/Kconfig         |   9 +-
 drivers/edac/Makefile        |   1 +
 drivers/edac/dmc520_edac.c   |   4 +-
 drivers/edac/edac_mc.c       | 135 ++++-
 drivers/edac/edac_mc.h       |   4 +
 drivers/edac/pasemi_edac.c   |   5 +-
 drivers/edac/ppc4xx_edac.c   |   5 +-
 drivers/edac/synopsys_edac.c | 927 ++++++++++++-----------------------
 drivers/edac/zynq_edac.c     | 501 +++++++++++++++++++
 10 files changed, 932 insertions(+), 660 deletions(-)
 create mode 100644 drivers/edac/zynq_edac.c

-- 
2.43.0


