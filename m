Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0326B1A727D
	for <lists+linux-edac@lfdr.de>; Tue, 14 Apr 2020 06:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405326AbgDNEWD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Apr 2020 00:22:03 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:36137 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405226AbgDNEWC (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 14 Apr 2020 00:22:02 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 2503506c;
        Tue, 14 Apr 2020 04:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=/hH2dwNNpfJr0mrnvSKMFgCR1fo=; b=z6aKUu
        IhPTlBq11eqKiOeduBfWdHibf2Hc/26bIHe0Zg5uvxXXIpO620osKO49JwC9TsdY
        YzAb+yhERc2uGG6dTziyntic8kv12Nzk4r+rr29181Fm/QsFguA///PdjHmVlECh
        eN/GIQhWsG45VPNAUkg0ftRXlLnOSr5K/iNklDTpWZ0+9BPPEt4cvoAEXx20OCcy
        fS4T9dAK4KpDmdKEzZ4pl94vjDn8kX+qED62U2NnWdlWgOnIJ1QKW2ZnhmCpnFpw
        yxS5GLSYfl7y/IqjCJ3ja2IzZQEeqKKYlH8/iUgF+1dBfjy6gL78H0KZfUWPnTXL
        gwiKDVS06InVfYHg==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 007e992f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 14 Apr 2020 04:12:12 +0000 (UTC)
Received: by mail-il1-f170.google.com with SMTP id t10so3515260ilg.9;
        Mon, 13 Apr 2020 21:21:59 -0700 (PDT)
X-Gm-Message-State: AGi0Puaq9is5OeFyRy/zZUcMSFjsMPXRa+1vSUIlzZeomyWG4830r9hS
        rKDmECcP+CQx7Gj4vFdeYXt6sWd82zGUPG95SC0=
X-Google-Smtp-Source: APiQypKXcoy7hmrc4HI8siWcJgS/tFKAznunN8DiJk9ZzkucbAVL0tASv7dumArcwiEAdFzc7CPl1/f2p6eN3jtCKzY=
X-Received: by 2002:a92:798f:: with SMTP id u137mr21468434ilc.231.1586838118738;
 Mon, 13 Apr 2020 21:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200407063345.4484-1-Jason@zx2c4.com> <bad9e0bd5504df83092c7add2d84331e164b60cc.camel@linux.intel.com>
In-Reply-To: <bad9e0bd5504df83092c7add2d84331e164b60cc.camel@linux.intel.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 13 Apr 2020 22:21:47 -0600
X-Gmail-Original-Message-ID: <CAHmME9rOzmF4K965U69tFZi2SS3rW9SHed2bJ=_PD+xu8LqMYw@mail.gmail.com>
Message-ID: <CAHmME9rOzmF4K965U69tFZi2SS3rW9SHed2bJ=_PD+xu8LqMYw@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/mce/therm_throt: remove unused
 platform_thermal_notify function pointer
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        bberg@redhat.com, bp@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Apr 13, 2020 at 9:56 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Tue, 2020-04-07 at 00:33 -0600, Jason A. Donenfeld wrote:
> > A long time ago platform_thermal_notify was added as some generic
> > mechanism for platform drivers to hook thermal events. It seems as
> > though this has been entirely superseded, and nothing uses it. Remove
> > the plumbing for this, since this code runs in an interrupt hot path.
> Good idea.

Will you take this into your tree? If not, how do your thermal patches
usually go in? A reviewed-by might be useful in that case.

Jason
