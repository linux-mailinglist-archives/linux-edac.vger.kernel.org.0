Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648BC274E92
	for <lists+linux-edac@lfdr.de>; Wed, 23 Sep 2020 03:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgIWBoD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 22 Sep 2020 21:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgIWBn7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 22 Sep 2020 21:43:59 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F4CC061755
        for <linux-edac@vger.kernel.org>; Tue, 22 Sep 2020 18:43:59 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id n2so23287857oij.1
        for <linux-edac@vger.kernel.org>; Tue, 22 Sep 2020 18:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jS6qXoxP8oaPPr4z/ISWBa/fqTB0t5njLCtqvmesqnQ=;
        b=G+hI5wX8b2Mgi7CpmlZz/BbRZ94AkUl88hXN1JwuQ34ehWFDDAH1EiGJlznX6Q1hkh
         leoTF4ALmGHjcSFCGWQTp9oolzWxQJAfHjJcY2uTD8jw1//YObslhst7+G02nWz+wJ6H
         SamX0bagHIpt+fJ/d7+7oToKKwlqUc5BpPiJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jS6qXoxP8oaPPr4z/ISWBa/fqTB0t5njLCtqvmesqnQ=;
        b=UgX/cz8mKGI8o4VEJLpkkVljzsi3isfhtfDEOn+RF8Z9zcPhxR6BWFBfw8lY4bDTOJ
         V0TTiRduU3O3+II0DaPzNfUqWpP4P3e6RpA6Qz56dspZglVdjmvd+YWO1j+/+ye2MVyf
         ajyhCLaw3lg45KEukX0Uk8lpTXH0lSGuqvUYpE+wz2tnW73jpWbcE1u6w6WrBlZCdq9a
         lY7K/f+4WkUdRywMsYg3pdzvv/1wmWSakhygARX7ZJexa+niiEXDqkOLS7qyOkC9d6HW
         iSvtPg6iugYR+964hHVA0b38UAkK/SD8EFQpysYUYfNLV0mmsLcYxU6rfhbmwoL8NLYz
         I2Iw==
X-Gm-Message-State: AOAM532wz6kEQs/gv5fxLQSV68uYNop4oOpq2ttQzJLyWbY+WgrkmmkR
        XjmoKBd+gYSSvro1pXOlcY1/uA==
X-Google-Smtp-Source: ABdhPJyPQg1FpZjcUx+RNaSk3Z0uB0vB4JXzkK2pjJD8AjXfQL76MIafNbVdr3ZrCY8bDGXBAwq3dg==
X-Received: by 2002:aca:4142:: with SMTP id o63mr4085367oia.167.1600825436078;
        Tue, 22 Sep 2020 18:43:56 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y23sm8801820ooj.34.2020.09.22.18.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 18:43:55 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        shuah@kernel.org, rafael@kernel.org, johannes@sipsolutions.net,
        lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        bp@alien8.de, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        hridya@google.com, surenb@google.com, minyard@acm.org,
        arnd@arndb.de, mchehab@kernel.org, rric@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-acpi@vger.kernel.org, devel@driverdev.osuosl.org,
        openipmi-developer@lists.sourceforge.net,
        linux-edac@vger.kernel.org
Subject: [RFC PATCH 00/11] Introduce Simple atomic and non-atomic counters
Date:   Tue, 22 Sep 2020 19:43:29 -0600
Message-Id: <cover.1600816121.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patch series is a result of discussion at the refcount_t BOF
the Linux Plumbers Conference. In this discussion, we identifed
a need for looking closely and investigating atomic_t usages in
the kernel when it is used strictly as a counter wothout it
controlling object lifetimes and state changes.

There are a number of atomic_t usages in the kernel where atomic_t api
is used strictly for counting and not for managing object lifetime. In
some cases, atomic_t might not even be needed.
    
The purpose of these counters is twofold: 1. clearly differentiate
atomic_t counters from atomic_t usages that guard object lifetimes,
hence prone to overflow and underflow errors. It allows tools that scan
for underflow and overflow on atomic_t usages to detect overflow and
underflows to scan just the cases that are prone to errors. 2. provides
non-atomic counters for cases where atomic isn't necessary.
    
Simple atomic and non-atomic counters api provides interfaces for simple
atomic and non-atomic counters that just count, and don't guard resource
lifetimes. Counters will wrap around to 0 when it overflows and should
not be used to guard resource lifetimes, device usage and open counts
that control state changes, and pm states.
    
Using counter_atomic to guard lifetimes could lead to use-after free
when it overflows and undefined behavior when used to manage state
changes and device usage/open states.

This patch series introduces Simple atomic and non-atomic counters.
Counter atomic ops leverage atomic_t and provide a sub-set of atomic_t
ops.

In addition this patch series converts a few drivers to use the new api.
The following criteria is used for select variables for conversion:

1. Variable doesn't guard object lifetimes, manage state changes e.g:
   device usage counts, device open counts, and pm states.
2. Variable is used for stats and counters.
3. The conversion doesn't change the overflow behavior.

Please review and let me know if non-stat conversions e.g: probe_count,
deferred_trigger_count make sense.

Shuah Khan (11):
  counters: Introduce counter and counter_atomic counters
  selftests:lib:test_counters: add new test for counters
  drivers/base: convert deferred_trigger_count and probe_count to
    counter_atomic
  drivers/base/devcoredump: convert devcd_count to counter_atomic
  drivers/acpi: convert seqno counter_atomic
  drivers/acpi/apei: convert seqno counter_atomic
  drivers/android/binder: convert stats, transaction_log to
    counter_atomic
  drivers/base/test/test_async_driver_probe: convert to use
    counter_atomic
  drivers/char/ipmi: convert stats to use counter_atomic
  drivers/misc/vmw_vmci: convert num guest devices counter to
    counter_atomic
  drivers/edac: convert pci counters to counter_atomic

 Documentation/core-api/counters.rst          | 158 +++++++++
 MAINTAINERS                                  |   8 +
 drivers/acpi/acpi_extlog.c                   |   5 +-
 drivers/acpi/apei/ghes.c                     |   5 +-
 drivers/android/binder.c                     |  41 +--
 drivers/android/binder_internal.h            |   3 +-
 drivers/base/dd.c                            |  19 +-
 drivers/base/devcoredump.c                   |   5 +-
 drivers/base/test/test_async_driver_probe.c  |  23 +-
 drivers/char/ipmi/ipmi_msghandler.c          |   9 +-
 drivers/char/ipmi/ipmi_si_intf.c             |   9 +-
 drivers/edac/edac_pci.h                      |   5 +-
 drivers/edac/edac_pci_sysfs.c                |  28 +-
 drivers/misc/vmw_vmci/vmci_guest.c           |   9 +-
 include/linux/counters.h                     | 343 +++++++++++++++++++
 lib/Kconfig                                  |  10 +
 lib/Makefile                                 |   1 +
 lib/test_counters.c                          | 283 +++++++++++++++
 tools/testing/selftests/lib/Makefile         |   1 +
 tools/testing/selftests/lib/config           |   1 +
 tools/testing/selftests/lib/test_counters.sh |   5 +
 21 files changed, 897 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/core-api/counters.rst
 create mode 100644 include/linux/counters.h
 create mode 100644 lib/test_counters.c
 create mode 100755 tools/testing/selftests/lib/test_counters.sh

-- 
2.25.1

