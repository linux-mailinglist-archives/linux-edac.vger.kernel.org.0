Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6809759647D
	for <lists+linux-edac@lfdr.de>; Tue, 16 Aug 2022 23:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237671AbiHPVP7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 Aug 2022 17:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237572AbiHPVPd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 Aug 2022 17:15:33 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB4185F85
        for <linux-edac@vger.kernel.org>; Tue, 16 Aug 2022 14:15:31 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id l10so11768074lje.7
        for <linux-edac@vger.kernel.org>; Tue, 16 Aug 2022 14:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=hnUM0lzwulX2q1QwimZooJGSc8HzCb0oOd/8o0YSo68=;
        b=IUeXHYYzD9fxgVydFxSvCAsPki9LKTYwV3j5xnWVDH/ou7lqf7ebeF5CFefctOBVYA
         bYBg34db1nLlG7TEoM2j89VjAY5t1KedRe/puyvrg3C9fxhwo4vS/VPB2GPncQUXO8gt
         3ctZJJBmQBUQ3ZQg+KSUpo08ceoUSgwEFm9lFH63Yy6W6maaYPT7gmve2k5AZDAIG1DP
         boXmhAgene/zqgStOQXo01Y8M0fsmT/SVMqB0tiM2Dng2bbF+aBArA07VXC4Y0BN/J9B
         UyzAM9NPgcq8RO1Akobuu3j7H0TeJveld828f6SsGXyhHMxhblYsHx9H9wawUDSv4Hho
         gyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=hnUM0lzwulX2q1QwimZooJGSc8HzCb0oOd/8o0YSo68=;
        b=A/LopQcnajEYEx88yt8XT6h4wfwj18YKMGBtUO98x2r39FeewuEKUcK47tVw/x0s09
         OH6h1qzXeGefamgq06mypabpux9o+dwAXrem56+YonJgIM3/M3eib56izD5Lq787vHyb
         0p7Oc0XnRn//JrRztyyMQkm3Bt7GrjXFN7BBEoMYkZtFfEYFrvyIqPOOWO4WixCUBIM4
         cRM7UHy5urv6J9FHhD3ATyYmubfFp+5N28n4JZrmE6why5Y/eJX5TBlbBbkWaNOJ6M/+
         +MWF67UP4avPtAaawWS2+0Q7UYXkAT2vrXW99zCyd/w1uHiT7liIeQ+FHxHM7W9r900A
         yfkw==
X-Gm-Message-State: ACgBeo1+1f8b/7PKo/E/IBpUut4KQQrCvp9sPWlETFCywMVwVGRw7RuV
        lVwgsJW8bGF42lJhNrZEz4ilCRcWVxjRLeaSrFo=
X-Google-Smtp-Source: AA6agR777wjONcOHVQXu/YK6jFO3Uv9EV2a+mJcblQPRfhwEkFtM788BnsuLaNIYCyELyY+tWRU9a2mqXDker9gL7sY=
X-Received: by 2002:a05:651c:14e:b0:25f:dbf7:8636 with SMTP id
 c14-20020a05651c014e00b0025fdbf78636mr7076171ljd.51.1660684529579; Tue, 16
 Aug 2022 14:15:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6504:410e:b0:1da:e5b8:73d with HTTP; Tue, 16 Aug 2022
 14:15:28 -0700 (PDT)
Reply-To: te463602@gmail.com
From:   "Mr. Yakubu Abubakar," <yakubuabubakar1884@gmail.com>
Date:   Tue, 16 Aug 2022 14:15:28 -0700
Message-ID: <CANt38esOhrFSqFxVaaMBcAca-V05Hx_7zG7MCE6quZ21nYAp6Q@mail.gmail.com>
Subject: Good Day,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:235 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [yakubuabubakar1884[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [yakubuabubakar1884[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [te463602[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

-- 
Hello,
We the Board Directors believe you are in good health, doing great and
with the hope that this mail will meet you in good condition, We are
privileged and delighted to reach you via email" And we are urgently
waiting to hear from you. and again your number is not connecting.

My regards,
Dr. Yakubu Abubakar..

Sincerely,
Prof. Chin Guang
