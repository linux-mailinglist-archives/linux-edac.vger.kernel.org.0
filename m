Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79FC7E173F
	for <lists+linux-edac@lfdr.de>; Sun,  5 Nov 2023 23:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjKEWBJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 5 Nov 2023 17:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjKEWBI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 5 Nov 2023 17:01:08 -0500
X-Greylist: delayed 5254 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Nov 2023 14:01:06 PST
Received: from SMTP-HCRC-200.brggroup.vn (unknown [42.112.212.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318A4DD;
        Sun,  5 Nov 2023 14:01:06 -0800 (PST)
Received: from SMTP-HCRC-200.brggroup.vn (localhost [127.0.0.1])
        by SMTP-HCRC-200.brggroup.vn (SMTP-CTTV) with ESMTP id 0405F19378;
        Mon,  6 Nov 2023 01:57:51 +0700 (+07)
Received: from zimbra.hcrc.vn (unknown [192.168.200.66])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by SMTP-HCRC-200.brggroup.vn (SMTP-CTTV) with ESMTPS id F14BC19377;
        Mon,  6 Nov 2023 01:57:50 +0700 (+07)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.hcrc.vn (Postfix) with ESMTP id 8E3631B8204A;
        Mon,  6 Nov 2023 01:57:52 +0700 (+07)
Received: from zimbra.hcrc.vn ([127.0.0.1])
        by localhost (zimbra.hcrc.vn [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Z6wcP0WNtPPS; Mon,  6 Nov 2023 01:57:52 +0700 (+07)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.hcrc.vn (Postfix) with ESMTP id 5F7FE1B8203A;
        Mon,  6 Nov 2023 01:57:52 +0700 (+07)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.hcrc.vn 5F7FE1B8203A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hcrc.vn;
        s=64D43D38-C7D6-11ED-8EFE-0027945F1BFA; t=1699210672;
        bh=WOZURJ77pkiMUL2pPLC14ifVPRvyTQIBEQmxuN1ezAA=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=Qf+6tBKQYTJBcxYoiRMIkLBcOCROqiU5e3Qm3xI/YUXxp7wYKn6j8Yci5tKFpmbfA
         ZRyPZsKoP8Bbp393MPb8H5eTukusEbFqVpPpkeu8tPcdvgEurJRGyGdzyo1psaqkwx
         ihMis8J3QdhGILs5b+vl1Adpy9OvASD/qN0t+vQNCVtp1NFnLfqiEMBzR3au8dsqaA
         PKBckwqCj+1zT+57GQ6jTpHI51OAneQp/GgAUrg0ZzWwQyfAyTFeWFq4jz4cRHS17+
         lNKIFOAVjL0wahdru+ShSYs7YYbCJ+eG84MU+QHPZw/yTEcjYDvBuquE1MDiGIa8tw
         U8qr2mepOyTuQ==
X-Virus-Scanned: amavisd-new at hcrc.vn
Received: from zimbra.hcrc.vn ([127.0.0.1])
        by localhost (zimbra.hcrc.vn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Kcbc6Oy5l-Rh; Mon,  6 Nov 2023 01:57:52 +0700 (+07)
Received: from [192.168.1.152] (unknown [51.179.100.52])
        by zimbra.hcrc.vn (Postfix) with ESMTPSA id EAED61B8223A;
        Mon,  6 Nov 2023 01:57:45 +0700 (+07)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?b?4oKsIDEwMC4wMDAuMDAwPw==?=
To:     Recipients <ch.31hamnghi@hcrc.vn>
From:   ch.31hamnghi@hcrc.vn
Date:   Sun, 05 Nov 2023 19:57:35 +0100
Reply-To: joliushk@gmail.com
Message-Id: <20231105185745.EAED61B8223A@zimbra.hcrc.vn>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Goededag,
Ik ben mevrouw Joanna Liu en een medewerker van Citi Bank Hong Kong.
Kan ik =E2=82=AC 100.000.000 aan u overmaken? Kan ik je vertrouwen


Ik wacht op jullie reacties
Met vriendelijke groeten
mevrouw Joanna Liu

