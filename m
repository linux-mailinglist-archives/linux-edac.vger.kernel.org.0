Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6DBE3DCA52
	for <lists+linux-edac@lfdr.de>; Sun,  1 Aug 2021 08:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhHAG12 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 1 Aug 2021 02:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhHAG11 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 1 Aug 2021 02:27:27 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF107C06175F
        for <linux-edac@vger.kernel.org>; Sat, 31 Jul 2021 23:27:19 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so1196892pjs.0
        for <linux-edac@vger.kernel.org>; Sat, 31 Jul 2021 23:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=GD47a1eb13BQ3GYOLHtMNKdf21XJ+B95voaoCDmsafk=;
        b=tbZqVU0V/3doX1mztE1mdb/RGomLLJOvRQR4m1E082D/bISE8t5kvlygX5CofteGvP
         AU9dTcEnFGMQwn0mHkNFyShYyVshnyBYdRXSUEiql9JltN2A3Z533sNE4aeBCumuaqct
         +O+jLTPpCz4jv28r9Tq7Gg/YWjfNolRqeHDwi64IsW61uBKGCpxFR99vCMVUFnAGmwZo
         Y0d+lRvRx1nEBUIowidzxNg1Qf466T/cd9YIhOfFss3LcIVC5bZUhJ91sPhAN4gS0xDm
         XuJzP75CFS+vig0bWFJM4XuFX56tMuRIJae9ltQ/lGwKTWlJGArIgU2SpUhupfjuqyg3
         yLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=GD47a1eb13BQ3GYOLHtMNKdf21XJ+B95voaoCDmsafk=;
        b=cxGyhYKHm/OhfvzWJGcY8HltV9hegFibB7dERUBQPcinVlJMmNVS0aKrfkN6soW6XG
         kRYg1bnTj6TyAbm+RRbXbvrtwpIVRIERWPqhQv+mbsMOxDIQkzMyJpV2X8VuZFq0XcsD
         ZXxX+H3zJcTomR1vVLQWQ62I6J0JF3Y1p1lgaz4GY/VtfxNCBHvS/ROlTTwSYUmAOlTG
         /qjT3KPzYMj2WwL3zFayv+9wp7Tuim3Mh0coey68nHFk63Y9glbdOq25JSn3BUjAxnsJ
         jCazRDE8clq+0XSYBaBSuzWIvtDqHvm+VH0uRBP4ihf3jJW6E3YKT/BFAWAB3y0KsftU
         e0TQ==
X-Gm-Message-State: AOAM53241H1KrGy+ilMHct+gS/Y4neMWptry+y90XyMcSCSlDuewoRfc
        AvV1V4SsPtYTlkRsyzWxNeAQ/YsDrM8Oeqp7WNaJNmaeKw4=
X-Google-Smtp-Source: ABdhPJz+3WuMOmtRBH3X7L7Tf2eSaDuoUQSCiRYJNKvOQAmjXXTqLIrrhjEFtkTHjxCYcAeJopfJopsNRJW8CUKMyag=
X-Received: by 2002:a62:1489:0:b029:336:162f:3417 with SMTP id
 131-20020a6214890000b0290336162f3417mr10882220pfu.14.1627799239230; Sat, 31
 Jul 2021 23:27:19 -0700 (PDT)
MIME-Version: 1.0
From:   nil Yi <teroincn@gmail.com>
Date:   Sun, 1 Aug 2021 14:27:08 +0800
Message-ID: <CANTwqXCcxMyJq8e4FM5ERJVNbPA01wCve769s6LcdYnSOnsXMA@mail.gmail.com>
Subject: [BUG] drivers: edac: edac_pci_sysfs.c: memory leak in edac_pci_create_instance_kobj
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,
there is a memory leak in edac_pci_create_instance_kobj in v5.14-rc3.

in edac_pci_create_instance_kobj:
174: err = kobject_init_and_add(&pci->kobj, &ktype_pci_instance,
edac_pci_top_main_kobj, "pci%d", idx);

kobject_init_and_add() should be handled when it return an error,
because kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object pci->kobj.

Any feedback would be appreciated, thanks :)


Best wishes,
Lin Yi
