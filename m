Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB62170619B
	for <lists+linux-edac@lfdr.de>; Wed, 17 May 2023 09:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjEQHrr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 17 May 2023 03:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjEQHrp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 17 May 2023 03:47:45 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A757C3ABC
        for <linux-edac@vger.kernel.org>; Wed, 17 May 2023 00:47:43 -0700 (PDT)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3D9353F436
        for <linux-edac@vger.kernel.org>; Wed, 17 May 2023 07:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684309658;
        bh=Prp+gvCFzgWy8Wr4AdCPMHWn8zkQL1ei83GgGU4GXHc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=qaOWXoCC+8ZS/x3mPNaFVuGzssozdvh+pnN6vUaGFETdaKSCGvwephz2AASeWoVhE
         e7mMQIyififEl8rc8KqLZ7vAuyIU6cRqRXRVob91AE5eP8Z82og5FL4haVY4lCR5w1
         0V+X+NHlRRONfSBShni2u82T2ykGporBIOKHjcbh0gfjt8IN0/seqDxDQ/nLl0e/P+
         sMlGOFFc+hGHxtJS362hgCKGkuzErTCyadLWcMFrBz3z3ATdPvFfed6MOvEXZx6oTw
         97+A1/ZYC5OnOFxzKoDIlgkXbS4ZZqnDyw0QWyA8Xe8NOKrEnmEqr5H2VTzZT3Ylvp
         O1P+L1qLMwH+g==
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-643fdc3e994so520770b3a.2
        for <linux-edac@vger.kernel.org>; Wed, 17 May 2023 00:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684309656; x=1686901656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Prp+gvCFzgWy8Wr4AdCPMHWn8zkQL1ei83GgGU4GXHc=;
        b=Er9Aehzh1bDMXP/kpLOX/Fc4vIVFDos8tNi1Uhw7UQYqqbvAvuB8yM9iXDPU7PX2YX
         QSGKKoCBHVsnp7YrWV0RIJxMbGwCYIwRdR/SSL5dgZ8VT1dWkEovgs8TnNZTx8L7pj1z
         +b3rOVZ25m7v/Gj4iVr+q/pX3tk2nqRjl1UTDFrPli1nN5lsUWdjwRs4ksIJPD7VGgbi
         /YEof49STBEAglkttbReTu5yxjBuVAhms194/elKiLaV7SfbznwZePXhnGQNTfYrGFvn
         j64d29n85MOtg/UPEDSggTJ25CHSTlepYW+0F5tOWYa+SIiB0LNwqq38UZSuXTy/1WnG
         syPA==
X-Gm-Message-State: AC+VfDyfRQJnIaBSZzMiim5gCB2jSg0dg2c6ua9X1KjFh+jR/sbuSEdm
        Ulgf4J87j14oTB4l0irTv4at/Cyy7XvPGWk087Tjg8NgtHz7SUwr0qCHZnnIOwC9+K6q62XibCK
        +UfqbyyEVonOyhI9i/3NvUX/F301CGQKkh/Lbou8q4OntG1MK82KCG6E=
X-Received: by 2002:a05:6a00:1507:b0:647:3de:c0ff with SMTP id q7-20020a056a00150700b0064703dec0ffmr42340786pfu.30.1684309656001;
        Wed, 17 May 2023 00:47:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6FbqLaYDTzFocG4a36CQQQ8fpuelvbMljb0kxtZcB09ddwN59whDaYuDB+DUJU+o/+04EHIOdHNRiwUhdTurg=
X-Received: by 2002:a05:6a00:1507:b0:647:3de:c0ff with SMTP id
 q7-20020a056a00150700b0064703dec0ffmr42340764pfu.30.1684309655711; Wed, 17
 May 2023 00:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230516033133.340936-1-kai.heng.feng@canonical.com> <IA1PR11MB61718EFB6DB1BF95CB1CEA5089799@IA1PR11MB6171.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB61718EFB6DB1BF95CB1CEA5089799@IA1PR11MB6171.namprd11.prod.outlook.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 17 May 2023 15:47:24 +0800
Message-ID: <CAAd53p5YhCpFgHat6Qv+T6id53NhJ=5W85wVeJvO6BW_W06kFg@mail.gmail.com>
Subject: Re: [PATCH] EDAC/Intel: Fix shift-out-of-bounds when DIMM/NVDIMM is absent
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "kao, acelan" <acelan.kao@canonical.com>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, May 16, 2023 at 8:53=E2=80=AFPM Zhuo, Qiuxu <qiuxu.zhuo@intel.com> =
wrote:
>
> > From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ...
> > Subject: [PATCH] EDAC/Intel: Fix shift-out-of-bounds when DIMM/NVDIMM
> > is absent
> >
> > The following splat can be found on many systems equipped with EDAC:
> > [   13.875276] UBSAN: shift-out-of-bounds in
> > drivers/edac/skx_common.c:369:16
> > [   13.875279] shift exponent -66 is negative
> > [   13.875280] CPU: 11 PID: 519 Comm: systemd-udevd Not tainted 6.4.0-r=
c1+
> > #1
> > [   13.875282] Hardware name: HP HP Z4 G5 Workstation Desktop PC/8962,
> > BIOS U61 Ver. 01.01.15 04/19/2023
> > [   13.875283] Call Trace:
> > [   13.875285]  <TASK>
> > [   13.875287]  dump_stack_lvl+0x48/0x70
> > [   13.875295]  dump_stack+0x10/0x20
> > [   13.875297]  __ubsan_handle_shift_out_of_bounds+0x156/0x310
> > [   13.875302]  ? __kmem_cache_alloc_node+0x196/0x300
> > [   13.875307]  skx_get_dimm_info.cold+0xac/0x15d [i10nm_edac]
> > [   13.875312]  i10nm_get_dimm_config+0x240/0x360 [i10nm_edac]
> > [   13.875316]  ? kasprintf+0x4e/0x80
> > [   13.875321]  skx_register_mci+0x12b/0x1d0 [i10nm_edac]
> > [   13.875324]  ? __pfx_i10nm_get_dimm_config+0x10/0x10 [i10nm_edac]
> > [   13.875329]  i10nm_init+0x89f/0x1d10 [i10nm_edac]
> > [   13.875333]  ? __pfx_i10nm_init+0x10/0x10 [i10nm_edac]
> > [   13.875337]  do_one_initcall+0x46/0x240
> > [   13.875342]  ? kmalloc_trace+0x2a/0xb0
> > [   13.875346]  do_init_module+0x6a/0x280
> > [   13.875350]  load_module+0x2419/0x2500
> > [   13.875353]  ? security_kernel_post_read_file+0x5c/0x80
> > [   13.875358]  __do_sys_finit_module+0xcc/0x150
> > [   13.875360]  ? __do_sys_finit_module+0xcc/0x150
> > [   13.875363]  __x64_sys_finit_module+0x18/0x30
> > [   13.875365]  do_syscall_64+0x59/0x90
> > [   13.875368]  ? syscall_exit_to_user_mode+0x2a/0x50
> > [   13.875371]  ? do_syscall_64+0x69/0x90
> > [   13.875372]  ? do_syscall_64+0x69/0x90
> > [   13.875373]  ? do_syscall_64+0x69/0x90
> > [   13.875374]  ? do_syscall_64+0x69/0x90
> > [   13.875375]  ? syscall_exit_to_user_mode+0x2a/0x50
> > [   13.875376]  ? do_syscall_64+0x69/0x90
> > [   13.875377]  ? do_syscall_64+0x69/0x90
> > [   13.875378]  ? do_syscall_64+0x69/0x90
> > [   13.875379]  ? sysvec_call_function+0x4e/0xb0
> > [   13.875381]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> >
> > When a DIMM slot is empty, the read value of mtr can be 0xffffffff, the=
refore
>
> Looked like a buggy BIOS/hw that didn't set the mtr register.

If that's the case, I suspect the bug comes from Intel BIOS RC,
because the issue happens on different vendors' hardware.

>
> 1. Did you print the mtr register whose value was 0xffffffff?

Yes, 0xffffffff is the value. mcddrtcfg is also 0xffffffff.

> 2. Can you take a dmesg log with kernel "CONFIG_EDAC_DEBUG=3Dy" enabled?
> 3. What was the CPU? Please take the output of "lscpu".

Both attached in Bugzlla [1].

> 4. Did you verify your patch that the issue was fixed on your systems?

I did, that's why I sent the patch to mailing list.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D217453

Kai-Heng

>
> Thanks!
> -Qiuxu
>
> > the wrong "ranks" value creates shift-out-of-bounds error. The same iss=
ue
> > can be found on NVDIMM too.
> >
> > So only consider DIMM/NVDIMM is present when the value of
> > mtr/mcddrtcfg is not ~0.
> > ...
