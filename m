Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C86C50DD42
	for <lists+linux-edac@lfdr.de>; Mon, 25 Apr 2022 11:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237932AbiDYJ6O (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 25 Apr 2022 05:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240263AbiDYJ5m (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 25 Apr 2022 05:57:42 -0400
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652951A056
        for <linux-edac@vger.kernel.org>; Mon, 25 Apr 2022 02:54:38 -0700 (PDT)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-2f7c424c66cso50368977b3.1
        for <linux-edac@vger.kernel.org>; Mon, 25 Apr 2022 02:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=s9IGPqOTuFEFxKMxMPq1P/MfyJrhGXNasZNiCUUGkGw=;
        b=ATyrrXg7Zde9kNKDF5ZCIwB8sFwpTlj1alooHiv5B82ElZ6NtBEuNx95Avx3yfEG+v
         SR3Pi9YiGn8JkKlYHD/qdytouxQeX3oJ0iJvxi83jqS7n6ODsQVEo3TYQchW3Es2L9VU
         WpUkJmlaB6wVhppaQWj/4q6pjGxtcDa4HJW4QOfeOpSLK6Z6UVte2AgKSDjpTAjhaUvp
         1vlu8JD8M0fsDcaE5ehzA10bFVyNVT/sZxFBm7wzmvCvDzerVUlRGvU96jP/8ljbUbru
         odoIA7j0rE1KKiANkkvBpPl/x2AfmHungJLTzDrn645E4r+5rvRovpsE1TzToHsa3UvN
         2Ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=s9IGPqOTuFEFxKMxMPq1P/MfyJrhGXNasZNiCUUGkGw=;
        b=IwClrVhJc87GzPfLHvQMK1Rjv6QA78mJ5vmzRdHpcB3iAcxna/i7yoZLptemPc4SUh
         omHyPn7JhLcfEn8+hl58B3Kqze6RGXZp8z8IFyUkg9CzVfNLc9VWaYOT83gVuRk32n8d
         ppuKJ6VT1FtPYPao8Ape7Y96Vne5CwloT4jv2ESb1vXA//k3qQRZdhHDm6wNwzzVI5CO
         kwmZHmRaLLe0/G8sjMF5JqTv5kFABC6ivXuGu9NDo9wmfYApun8rln6J3y52vE+BpEek
         mOtA4P0M8aYmOP0sINOmCwfD7wO5urm1nNnxC/r1CH81ikFYzpoev0F41u/ry4xlsl8x
         4sfA==
X-Gm-Message-State: AOAM530DtEk8/plTLVTHwLzaESp06B1VJGaTeLoOSHPjB9hFC+9E5lXV
        NoKDJMMDrMrZmsblNgy0xl+cSkiMofvrOF7irC0=
X-Google-Smtp-Source: ABdhPJxQijnkVqO46AP9dZFBb+zIV+lJgA02aHBxz50/JloNDj/GM6qY165L4Ew15qf1giwmqZ6pYLM3j+WeCcqd3IM=
X-Received: by 2002:a0d:d787:0:b0:2f4:dfc5:9a70 with SMTP id
 z129-20020a0dd787000000b002f4dfc59a70mr16308194ywd.447.1650880477612; Mon, 25
 Apr 2022 02:54:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:bf06:0:0:0:0 with HTTP; Mon, 25 Apr 2022 02:54:37
 -0700 (PDT)
Reply-To: lawrencetansanco.y@gmail.com
From:   Lawrence Tansanco <lt01102203@gmail.com>
Date:   Mon, 25 Apr 2022 09:54:37 +0000
Message-ID: <CAHP1huHfPzicY=hdR831QxbM-x=dFovv4_naSGV3EfxdN+Ra9g@mail.gmail.com>
Subject: THANKS FOR YOUR RESPONSE AND GOD BLESS
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1141 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4808]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [lt01102203[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [lt01102203[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

.
I will like to disclose something very important to you,
get back for more details please.

Regards.
Mr Lawrence Tansanco Y.
