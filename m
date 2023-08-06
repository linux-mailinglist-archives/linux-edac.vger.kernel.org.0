Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624DE77145F
	for <lists+linux-edac@lfdr.de>; Sun,  6 Aug 2023 12:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjHFKQp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 6 Aug 2023 06:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjHFKQo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 6 Aug 2023 06:16:44 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84551131
        for <linux-edac@vger.kernel.org>; Sun,  6 Aug 2023 03:16:43 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe5695b180so4368965e9.2
        for <linux-edac@vger.kernel.org>; Sun, 06 Aug 2023 03:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691317002; x=1691921802;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8q/bagFOvN6qezTjY/Fc6ELUIBJT91rhylGykx1oo1s=;
        b=mi9q4KvckOuN6R+R6A0qZ30bPiuk962bBbq0ThwvrxKvXZ+C3/fiJLJZ53AYsAstb7
         APwGZpczhsHsHyQCtvmLz76AQ0kX0iogCT39wVky69zc+tyliNabt8t2QuerBnsTgxgh
         uEqstQCaWN2dsdgW/o1CAx04gH7ZR/b2IaDkp8XJG/Fhd/N58CuyeSZqFop8/uKxBRoM
         9Rwy5DEZ8VvhE5BLbjXjnS6+/iUw1Bp15PGhQKW3xTsnHJrd3UepY2hUiXcjZZPugfq8
         +RZldhxymYumsv3CRlpkEqQIdf3CKAOjUJMS8l/pJ3UBm+KT4oh1BGF5n4LO5+P3Ei+9
         Ft6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691317002; x=1691921802;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8q/bagFOvN6qezTjY/Fc6ELUIBJT91rhylGykx1oo1s=;
        b=RMXvefxiszU14UtI6ZD5T6rGYihswsV3AX0mE7Z89qvJDW1jj3yIqmzNaTx3ARp8pS
         /bCS+f3URCs/cL0XIx5kfjnLooMymfKFET1zg5DrUCA4svbGQ9Kky+aWSs3Rki60Ohv+
         WBP4HGzBYSU6xLtequEIRdcFRbbkKi/Kna2yCqs9gkPjY5OTg6+ZGiuyuOkArDOjhe0e
         dYQxuc/O8wbnXMO/8pwRgWftrF6T1rc5cfZoO1AkFQtgPHQgk4+5WVjprN4CFUIWppl9
         4dHsUDl0GQWjbmzQFM3PAkXeSCGNnwnDNzKJsVlIYJIlI/QJMwJaPs1IQW+Ec6li2tx2
         mU2Q==
X-Gm-Message-State: AOJu0YzGEhxlIhkWMtRW0I/gVzU+z7zgaYGJ0TV7NYswctAl3g2ZBt72
        XanGcPfDhtgR59LTJ+Q/D8ieTGsnF9uPMh63+RUw8Xi3Lfqlf9gB
X-Google-Smtp-Source: AGHT+IHiCd6Beq5v1jF1PlbpIumMmMJ81XBEqTb5+rcMarPSlBkdMak78RiUFRG/aZ7dM065wlDHRUKefAWPCLhfWJA=
X-Received: by 2002:a7b:c8d4:0:b0:3fb:e189:3532 with SMTP id
 f20-20020a7bc8d4000000b003fbe1893532mr4366512wml.20.1691317001565; Sun, 06
 Aug 2023 03:16:41 -0700 (PDT)
MIME-Version: 1.0
From:   Raz <raziebe@gmail.com>
Date:   Sun, 6 Aug 2023 13:16:30 +0300
Message-ID: <CAPB=Z-pEto2T+WbA8_nEk2GyVo70_gZDCGLjdm1GgNJ9vH8OFg@mail.gmail.com>
Subject: EDAC device notification
To:     linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello
I wish to extend the EDAC interface to register device drivers.
I want the device driver to be able to be notified when an error occurred.
I want the EDAC to get notified when a device registers.
Here is my suggestion:

edac.c
~~~~~~

// edac_notifier_chain may be used by any device driver
static BLOCKING_NOTIFIER_HEAD(edac_notifier_chain);

//
// This is called from each device to EDAC to perform
// any special configuration, if required.
int edac_register_device(struct device_driver *dev)
{
                list_for_each(item, &mc_devices) {
                                mci = list_entry(item, struct
mem_ctl_info, link);
                                rc |= mci->register_device(dev);
                }
                return rc;
}

Kind regards
Raz
