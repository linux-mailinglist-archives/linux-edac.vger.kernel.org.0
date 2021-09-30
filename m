Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9B241D69A
	for <lists+linux-edac@lfdr.de>; Thu, 30 Sep 2021 11:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349528AbhI3Jqp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 30 Sep 2021 05:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349464AbhI3Jqo (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 30 Sep 2021 05:46:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96C3E615E2;
        Thu, 30 Sep 2021 09:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632995101;
        bh=6uyUfnKfZKksnyKfEttmmzOHPPjEBQZsOjCQp7fyIO4=;
        h=From:To:Cc:Subject:Date:From;
        b=DtCbzDSToSyq5ei+OpNZqPMVRsGIMcwUTxlPHpGXjJCZUsylJsx0oQsDiFgJL6Z3L
         j2VSzGq87EXEGR7qHc1zTXUBKo+Z8dCnM2y67faMqkirhp5Rd0aEmkjDZK1mYhNcjL
         Iyl5AwHZwBwOuZBM2jf/CakNbKTK4e4PpJrdR1QGCW5IsZMe/fXuszlLMZts6+cHm9
         0nahN/Bh7a82fXlfqAST3NfjmaUsnhMAZD41r32gwWQrOMpNp2lnvAfb1yU4IiseD4
         95JDg04R7UrD9H/miRE2e5SSJIh709R5GWREqkJUFRp7Aab8TIlD+VWxDGyZyyCCs+
         CicLWfui4uMNQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mVscd-002AT1-IQ; Thu, 30 Sep 2021 11:44:59 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Amit Kucheria <amitk@kernel.org>,
        Anatoly Pugachev <matorola@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Carlos Bilbao <bilbao@vt.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ingo Molnar <mingo@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Peter Collingbourne <pcc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Rix <trix@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, x86@kernel.org
Subject: [PATCH v2 0/7] ABI: add additional sysfs docs and update some other ABI files
Date:   Thu, 30 Sep 2021 11:44:47 +0200
Message-Id: <cover.1632994837.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Greg,

This series contain:

patch 1: Convert sys/class/thermal to Documentation/ABI;
patch 2: Convert sys/class/hwmon to Documentation/ABI;
patch 3: add a new sysfs element on hwmon that weren't documented yet;
patch 4: Convert MCE sysfs documentation into Documentation/ABI;
patch 5: Add 3 missing elements to MCE sysfs documentation;
patches 6 and 7: fix wildcards at sysfs-class-extcon and sysfs-devices-system-cpu.

Those help to reduce the gap of undocumented ABI detected by:

	./scripts/get_abi.pl undefined

On an ARM and on an AMD x86_64 server.

Mauro Carvalho Chehab (7):
  ABI: sysfs-class-thermal: create a file with thermal_zone ABI
  ABI: sysfs-class-hwmon: add ABI documentation for it
  ABI: sysfs-class-hwmon: add a description for tempY_crit_alarm
  ABI: sysfs-mce: add a new ABI file
  ABI: sysfs-mce: add 3 missing files
  ABI: sysfs-class-extcon: use uppercase X for wildcards
  ABI: u: use cpuX instead of cpu#

 Documentation/ABI/testing/sysfs-class-extcon  |  12 +-
 Documentation/ABI/testing/sysfs-class-hwmon   | 932 ++++++++++++++++++
 Documentation/ABI/testing/sysfs-class-thermal | 259 +++++
 .../ABI/testing/sysfs-devices-system-cpu      |  52 +-
 Documentation/ABI/testing/sysfs-mce           | 129 +++
 .../driver-api/thermal/sysfs-api.rst          | 225 +----
 Documentation/hwmon/sysfs-interface.rst       | 596 +----------
 Documentation/x86/x86_64/machinecheck.rst     |  56 +-
 MAINTAINERS                                   |   5 +
 9 files changed, 1404 insertions(+), 862 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-hwmon
 create mode 100644 Documentation/ABI/testing/sysfs-class-thermal
 create mode 100644 Documentation/ABI/testing/sysfs-mce

-- 
2.31.1


