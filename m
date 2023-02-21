Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D670069EA4F
	for <lists+linux-edac@lfdr.de>; Tue, 21 Feb 2023 23:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBUWkJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 21 Feb 2023 17:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjBUWkI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 21 Feb 2023 17:40:08 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC6233447
        for <linux-edac@vger.kernel.org>; Tue, 21 Feb 2023 14:39:45 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id c200so1070073qke.2
        for <linux-edac@vger.kernel.org>; Tue, 21 Feb 2023 14:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=student.uny.ac.id; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=twdHZET46/F5vizXZVz+VqY+7tyjVRdIagVq9V6tRJk=;
        b=cVKJtoxl0acMJJIwk2hPq/3OBRAVc3EM9BTjXkgsWpgp3u8vCPV+mvlUgevijcZKdW
         yKj8d3Y4qZ/9Eg4qdy1/0Sjmdyk4QHndg3BF3zGn01jkeCIG/n84qxJOD+5RCglv7RTg
         zgbWh0R5Qoo5t2ONfaAYyTgxRyLLvUHoBz9kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=twdHZET46/F5vizXZVz+VqY+7tyjVRdIagVq9V6tRJk=;
        b=iccXJ5WD9yELPfSoVRgzf3El1yxlNpsF8bOyWQ6CjE2Y/OF8DmwqWQEeWW//IHHi5h
         L2j8XRBWTJxIpT1BJcVZ6EYK1pTer0nmjFKlGwoqNDjQ9WPqN+1gExvlnI+10Zhw+CQ6
         oVAsDN3EyQzkD9Vrd92IFu5zEMlUJP78SoxoM9Ho0Hxk8qrkFy0JL9fT9njTPUilo3tr
         drZ1j+pkUlBT5tzinCp/JDHHnKip+F5qqGe6KaIuxAHoGkhg7NhRm8ZoKjCQhB9eLeKg
         53MNloeww5e1gYFbKj7SRJ0lLepUBnLYzBMz+PcRqCGAx/Y634mEEp4hVp0UZAizm6gS
         O2yg==
X-Gm-Message-State: AO0yUKW+0QU2fg/l1TZa1yMAacSc/gX9vmLVaxL1ioMjoAlhtueFsC5g
        4toqTBmld9ZJ+2qdkB0TlvFuUIEOUFyjjKJotfBZvqAlkGEnHUHzHiEwT866KoVtFhNdjXfBxh3
        RRY2tIDsun6cee/Cv6+6AWWBD3wEj13w=
X-Google-Smtp-Source: AK7set9PVR2O2g1LA2BTqu0GQ4mejJLHgcyO/A2UM74GZNzISHf07Zjuehx61mmaKFvYJflBCdhC2Mef2eDCGiE0d3s=
X-Received: by 2002:a37:c407:0:b0:71f:b89c:5acc with SMTP id
 d7-20020a37c407000000b0071fb89c5accmr797707qki.13.1677019183596; Tue, 21 Feb
 2023 14:39:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6214:3d03:b0:571:1c44:3b16 with HTTP; Tue, 21 Feb 2023
 14:39:43 -0800 (PST)
Reply-To: fdx.s@yahoo.com
From:   CommonWealth Of Nation Donation 
        <fadilahutami.2018@student.uny.ac.id>
Date:   Tue, 21 Feb 2023 23:39:43 +0100
Message-ID: <CAMHH5kh2fSea_DnxFXF520qiR7hbQih-aLXeS_FAaRA+aiNE6g@mail.gmail.com>
Subject: Your Bank Draft Of $800,000
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_REPLYTO,LOTS_OF_MONEY,
        MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY,XFER_LOTSA_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:730 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 XFER_LOTSA_MONEY Transfer a lot of money
        *  3.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The Commonwealth of Nations wishes to inform you that the
A sum of $ 800,000.00 USD has been donated to you.This is a donation
relief for Covid-19. Please contact for Claims


Regards
Kerry Russell

--=20



-------------------------------------------Untuk mendukung =E2=80=9CGerakan=
 UNY=20
Hijau=E2=80=9D, disarankan tidak mencetak email ini dan lampirannya.
(To support=20
the =E2=80=9CGreen UNY movement=E2=80=9D, it is recommended not to print th=
e contents of=20
this email and its attachments)
Universitas Negeri Yogyakarta
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=20
www.uny.ac.id <http://www.uny.ac.id>
-------------------------------------------

