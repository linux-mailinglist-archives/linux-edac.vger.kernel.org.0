Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E01853591E
	for <lists+linux-edac@lfdr.de>; Fri, 27 May 2022 08:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244601AbiE0GMO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 May 2022 02:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244442AbiE0GMN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 May 2022 02:12:13 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC7E33A3D;
        Thu, 26 May 2022 23:12:11 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id m14-20020a17090a414e00b001df77d29587so6290985pjg.2;
        Thu, 26 May 2022 23:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZAlldb2wH2bL38lLFGDzvhlgJH9fckgtEngrU/7mnKQ=;
        b=JUte5ROejFtPr4qcj9S5BngrYLpd98aiXliHpX+d4/ctRXhVkplCZ5C+ILFzDL+OeB
         StZwgR3GjGUh/ikekEYPkxByrC+khZUXMQ3aSqK60yGXDD/oZWEGGKVn9R9atD9z/PRp
         14JU7/fCj/sAHJqDdJ/gG9TUlWpdYkOSXMC2iNk6y+Afb5XDfLDlA5q4vS6b9fmn7GNW
         16rC9PBNdA4HXVKH682gwJu42pn7ac9hChjE4dTKjDO0lB6qOWNsEQwxDaOxjWMW27lI
         QOVz4ZZ59xFGbmXPF4qK79HbsHS7CFUuMQ6lpiqlyLQM43WjrksO2DMH/HDQSwcBeCDv
         JeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZAlldb2wH2bL38lLFGDzvhlgJH9fckgtEngrU/7mnKQ=;
        b=2LZ2L13FXmN0c1WU0swN5UUinjOVHNEJ0QV34FQ7tYWvKXeKCxRX+RVjqrsSFBmxq9
         jF8gDb1m9yPnf7aYCeM3EipVDtas4cfXN1AU/QX1fIeiYQHwWoNIAzbPVK+rLvVVA8rS
         h+WiJ1nn8s2KTDuKKAj9c5v+/WK2qkE7wNvZc/EFn+m767xBwVp6V7lCwjVhrFyqjIjh
         RvAx550C45IBrWs0ywaVonfBI3wwGaLaSh8YaBZJUkPg9LI/OuDEr2FjK5DS0AxCVDHU
         oTLIiKLyxzERMgu0sdLDRC71Wg3++Ha6EotcfMgD7rM1fb54C1xjlYp4CUfIQRqkcOw0
         +O8Q==
X-Gm-Message-State: AOAM5335PAk9d9b02exhGhdtuanVy1C/Niodo+gyqSEvNawrSIwhUHES
        iNQoOjwUf5gQcJmcnbizDEQ=
X-Google-Smtp-Source: ABdhPJxey0GCdTYlVG9dNz8UlMSy7COIPK6OHN3MZarfjSP3vxb/SqLZLCqan9vfGYZy4t/qM5kqXw==
X-Received: by 2002:a17:90b:3192:b0:1df:7b5a:2047 with SMTP id hc18-20020a17090b319200b001df7b5a2047mr6601246pjb.138.1653631931252;
        Thu, 26 May 2022 23:12:11 -0700 (PDT)
Received: from localhost.localdomain ([116.89.143.231])
        by smtp.gmail.com with ESMTPSA id b10-20020a1709027e0a00b0015e8d4eb2c2sm2636306plm.268.2022.05.26.23.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 23:12:10 -0700 (PDT)
From:   medadyoung@gmail.com
X-Google-Original-From: ctcchien@nuvoton.com
To:     rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, robh+dt@kernel.org,
        benjaminfair@google.com, yuenn@google.com, venture@google.com,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, JJLIU0@nuvoton.com,
        KFTING@nuvoton.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, ctcchien@nuvoton.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v11 3/3] EDAC: nuvoton: Add NPCM memory controller driver
Date:   Fri, 27 May 2022 14:11:48 +0800
Message-Id: <20220527061148.14948-4-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220527061148.14948-1-ctcchien@nuvoton.com>
References: <20220527061148.14948-1-ctcchien@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Medad CChien <ctcchien@nuvoton.com>

Add memory controller support for Nuvoton NPCM SoC.

Note:
    you can force an ecc event by writing a string to edac sysfs node
    and remember to define CONFIG_EDAC_DEBUG to enable this feature
    example: force a correctable event on checkcode bit 0
    echo "CE checkcode 0" to below path
    /sys/devices/system/edac/mc/mc0/forced_ecc_error

Datasheet:
    Cadence DDR Controller Register Reference Manual For DDR4 Memories
    Chapter 2: Detailed Register Map

Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f832e6ed4e5..8919fb83f485 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2372,9 +2372,9 @@ F:	arch/arm/boot/dts/nuvoton-npcm*
 F:	arch/arm/mach-npcm/
 F:	drivers/*/*npcm*
 F:	drivers/*/*/*npcm*
+F:	drivers/edac/npcm_edac.c b/drivers/edac/npcm_edac.c
 F:	include/dt-bindings/clock/nuvoton,npcm7xx-clock.h
 
-
 ARM/NUVOTON WPCM450 ARCHITECTURE
 M:	Jonathan Neuschäfer <j.neuschaefer@gmx.net>
 L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
-- 
2.17.1

