Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC556D9F87
	for <lists+linux-edac@lfdr.de>; Thu,  6 Apr 2023 20:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjDFSJT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Apr 2023 14:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239899AbjDFSJS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 6 Apr 2023 14:09:18 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03B78689
        for <linux-edac@vger.kernel.org>; Thu,  6 Apr 2023 11:09:16 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-935558f9f01so114505466b.3
        for <linux-edac@vger.kernel.org>; Thu, 06 Apr 2023 11:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680804555; x=1683396555;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nhffWdZlth4aByLd785lLkc7TK3WnZSx3/zqQGno3Y=;
        b=W8oH7nV8HbmomwaVlLY+U6C8kYrR7qztrDla7H829oR8o2FH6jc6yXKYctYvg5BePb
         +4H5wXihQ+nwRQzW9GMoSxvQoefRXAHDX5GPYevnSK21Bfl45srkbQvOf0t8jB3r59e0
         BiJQKt3YsoAuhBfT2/CUfWyTcGPFF/Db6EWwKgj3DatXplS3QvxJjf26slZFOWcnEW2S
         VNwThrUl0q8qlENYvbs8KEo8mti3K+DuE8KfPo7LFRfq76k5zC3tmvLDBx9MIL1hwTGu
         rtGHCfba1ZFXhiaOCrqOrNKFAQDg+HtHqID/FawCqfNxXHLqzxMuf2j65zSeACUW8cNg
         A8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680804555; x=1683396555;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8nhffWdZlth4aByLd785lLkc7TK3WnZSx3/zqQGno3Y=;
        b=Y83eez/MuFn8tVEEVR0FALH/5ieW6ZaGNrI7EVFRPO16QyhwXKXn23dvRDR7hh4BAE
         mVb+5+K7JmESbH2bm0SN95dOXLhucx2RMaRaQG5DnFKx1JoQ6kLRV26JHbzyhAerp86h
         THKonzPuQrME/Bfm/p4vGBuGe0e0vkKr7SZypd55+22+tEi9U/LWPbyV4QfxWc9t7PeW
         b5PhjwEZOLE7eFtKWn2/g7mOJLZjna/rjEET7A/ot20ckWwPsCyeDdLAH1d+Eo0bepEE
         E2hX/ubWkJOJCjE++/uLw5ZKgxSW1+6n9JLkiS9JfYu3Chb+QB4om3eY47+azHbg6yaz
         TQ4A==
X-Gm-Message-State: AAQBX9dpHkv177ququBh8teC+yYJPVXswRH2cZ/wvlJSRCyk2FRnUNrR
        GwHpZkcuFgJxc4slndJ9GCDCjGj7pjrcX7c4Y94=
X-Google-Smtp-Source: AKy350bZZYV8kPEAXzzDcCal2Ql53oij736lzsbchUYOl/HyckYyfe4+MfkNepBiObN5lelbS6mPlxcoP07Dt+tKFkc=
X-Received: by 2002:a50:d716:0:b0:502:6d4b:40f5 with SMTP id
 t22-20020a50d716000000b005026d4b40f5mr212923edi.7.1680804555150; Thu, 06 Apr
 2023 11:09:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:97d6:b0:947:d885:520a with HTTP; Thu, 6 Apr 2023
 11:09:14 -0700 (PDT)
Reply-To: elenajyak@gmail.com
From:   "Miss.Elena Yak" <airportauthorityp.bf@gmail.com>
Date:   Thu, 6 Apr 2023 18:09:14 +0000
Message-ID: <CAGVeOqx6v+7AE2FtNiz42Dyix-gEZJH+=wL3BKRaQdOa8fMihQ@mail.gmail.com>
Subject: Re:Good Day
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:634 listed in]
        [list.dnswl.org]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [airportauthorityp.bf[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  3.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello Dear Friend,
My name is Miss Elena Yak, I am looking for good relationship I got
your E-mail address/profile through my internet search and I have
something very important to discuss with you. However please do reply
me through my email address,(elenajyak@gmail.com)is to tell you more
about me and my pictures. It is my pleasure to have you as a friend,
Thank you so much and God bless you, bye! Your friend Miss. Elena Yak.
