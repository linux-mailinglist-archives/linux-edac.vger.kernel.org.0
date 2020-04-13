Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4CC1A6DCA
	for <lists+linux-edac@lfdr.de>; Mon, 13 Apr 2020 23:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388784AbgDMVJZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Apr 2020 17:09:25 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:45059 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388773AbgDMVJY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 13 Apr 2020 17:09:24 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 58a86fa8;
        Mon, 13 Apr 2020 20:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to
        :content-type; s=mail; bh=GJhanwEeipb7zodQ50+5hF7m83c=; b=DjJ+Ow
        L+mRbSnAeyT5MVG3smFb7WXY/bYUj8yX0nwfmcIfi67ceRogayi6QwjD9omFGwV4
        8Yy/fVUC5ktFpwA2V66seTqKEPmmu/ZhuCRUhrFM1JNwtZDVRUB0WAw+TcjAJBZD
        uhSdWZM7nRubxNS5HjHSp6+/Z7k/nPPSlCTg1rc1Gu2hkO/guXKaCXDToQ0erYCj
        34qR9q0PD+vxdndWzb1ToTPzcxPxX4b8o0607YtXDyLV4qioQ/wNPA4B2bKqmxp9
        7tlzb87xPWqnebeQknbzG5/Np2A9cEfBO2bezRIf13APBk+11gEvFreIOOBkixPd
        3ZYog/+LsfL5ukfg==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e2bd287b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 13 Apr 2020 20:59:31 +0000 (UTC)
Received: by mail-il1-f172.google.com with SMTP id e4so7619943ils.4;
        Mon, 13 Apr 2020 14:09:15 -0700 (PDT)
X-Gm-Message-State: AGi0PuZPxauZRwoBFtbj8zhYiXx17Lv2VjtVIB7U3gMV8UDOgIN+f05C
        SzCLviLQKFqqpfOF71IAYNQ6AjsHQ3P5cx5eZ+4=
X-Google-Smtp-Source: APiQypJCLeSpS94nQ2mW7IqNggzIAnxsuBr35zrilZtRQ3Khy5xH0OVu0prrddC4LXjW95CUnRVZ+vmU+pJaj54jXvQ=
X-Received: by 2002:a92:d98c:: with SMTP id r12mr547554iln.224.1586812155136;
 Mon, 13 Apr 2020 14:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200407063345.4484-1-Jason@zx2c4.com>
In-Reply-To: <20200407063345.4484-1-Jason@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 13 Apr 2020 15:09:04 -0600
X-Gmail-Original-Message-ID: <CAHmME9qL0hJASP=LAX3bViqmEUH1Fu4tw_9UaxfPgCXygBPk3Q@mail.gmail.com>
Message-ID: <CAHmME9qL0hJASP=LAX3bViqmEUH1Fu4tw_9UaxfPgCXygBPk3Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/mce/therm_throt: remove unused
 platform_thermal_notify function pointer
To:     LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        srinivas.pandruvada@linux.intel.com, bberg@redhat.com, bp@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Srinivas & Co,

Could you have a look at this three part series please? Friendly poke.

Jason
