Return-Path: <linux-edac+bounces-5300-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 843E9C2D10D
	for <lists+linux-edac@lfdr.de>; Mon, 03 Nov 2025 17:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58661188BD6B
	for <lists+linux-edac@lfdr.de>; Mon,  3 Nov 2025 16:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D363161B3;
	Mon,  3 Nov 2025 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxZK56Ol"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143EF3161A4
	for <linux-edac@vger.kernel.org>; Mon,  3 Nov 2025 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186796; cv=none; b=CwqtgajX3ac6VNpjBQSLbQOTs9pgz/YX/8prTqxdsiKj1ijLh1wUSPr/WWm4SCWxMIpIEGTfLHpKhTv3jLYn2mLDFZkbveruZx+ZJNDd1bn2qbXYnSz+Dh2n/Cu7ws7pEK8xdp+2qlwaIPTIbxpRSrwlZovwHmXJtYiZcjBfq4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186796; c=relaxed/simple;
	bh=Sk3YUo7dUQtfztKAt03QLqMqer/FMN4d3z80Z8X0gQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNoAfkU/NhxEFtcPBrBH7h3Rtqj/OZuM4bXWPfG6TUUXWxIMLeSuUc3VbGiqenZu3iB6CHC1u3+NMisL6EOXVGnR5m3Mk37sWZk0zvY3aYUMDNiDgfg3wP7D2nwkTXUI1hXgLxsaqdNzhOBHFmDQdK1qeJGJbWqkvq/6T6VciVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxZK56Ol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC112C116D0
	for <linux-edac@vger.kernel.org>; Mon,  3 Nov 2025 16:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762186795;
	bh=Sk3YUo7dUQtfztKAt03QLqMqer/FMN4d3z80Z8X0gQY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dxZK56OlymerAXSLwcLJt5wUMBCeKIIy9k9GZrQIWtIybqxFAG8HG5eoRNsFV1W8G
	 LQmGxQHV6ltIL3yHCFC1ZNy53wFCeSEoTPc0yw1eE3ENLLRJO45ic9q/r2nG/+wgFY
	 ELkmJT1boKpiZjKxsCrgystfh2kWIvg+LAJHXn0A8525tXiVO6Fjy9b3m065jzMo05
	 9OE+JYZs4ewGR8lOjokWdhW2QfC917+q9iNK447Mpr1ycV0G8ahkUHGdA6dKxtugSb
	 xe2TIiC5CQhtwMvBVc7TBnLdt5sFpD6jBD2kw01inXCrgklxuYNintL75CBU+fNe/+
	 WTETAAUJ7TKtw==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7c52fa75cd3so3625636a34.3
        for <linux-edac@vger.kernel.org>; Mon, 03 Nov 2025 08:19:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV4NMX5SU22WhUV4QdbMHvUGhVkAvzxj7TwYbYpKNQSb0bm9OS2Z7Jxt/ukLzm7nI5DPwfONVxhq8XA@vger.kernel.org
X-Gm-Message-State: AOJu0Yxly43a8h8TEsbLlhpzvxUB75QmU5mlb5Fbh3NKFABclXHH+fy1
	v1tDkNetDMctVX1MGz64IhJPfxqURZJtMPWCgNDsQm9X6bvJSnu2QdLFFgjy41ndGbzqnx21k6c
	HtS9eO40BmnD20e6SkjEoshzQj7dgnpY=
X-Google-Smtp-Source: AGHT+IG3361toIoasB3uOKUzNV6dinGA22EHyvpJDIQt6UYgSrpZaDoMHd819oZo8awumREm/GvNri9dakziMUuH1og=
X-Received: by 2002:a05:6808:d4d:b0:438:39a2:b61c with SMTP id
 5614622812f47-44f95dfb174mr5549335b6e.2.1762186795085; Mon, 03 Nov 2025
 08:19:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030071321.2763224-1-hejunhao3@h-partners.com>
In-Reply-To: <20251030071321.2763224-1-hejunhao3@h-partners.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Nov 2025 17:19:43 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h=QtcT7zhZEgrTjUk7EAk2OfbGG6BoEEv-3toKODMXQA@mail.gmail.com>
X-Gm-Features: AWmQ_bk1ceWWT4cSZSU5mE1myDtpg3UPaMnBHWg-zIlq7JFILI41pAtQ3N0MKOQ
Message-ID: <CAJZ5v0h=QtcT7zhZEgrTjUk7EAk2OfbGG6BoEEv-3toKODMXQA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: Handle repeated SEA error interrupts storm scenarios
To: Junhao He <hejunhao3@h-partners.com>
Cc: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com, 
	mchehab@kernel.org, xueshuai@linux.alibaba.com, jarkko@kernel.org, 
	yazen.ghannam@amd.com, jane.chu@oracle.com, lenb@kernel.org, 
	Jonathan.Cameron@huawei.com, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-edac@vger.kernel.org, shiju.jose@huawei.com, tanxiaofei@huawei.com, 
	linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 8:13=E2=80=AFAM Junhao He <hejunhao3@h-partners.com=
> wrote:
>
> The do_sea() function defaults to using firmware-first mode, if supported=
.
> It invoke acpi/apei/ghes ghes_notify_sea() to report and handling the SEA
> error, The GHES uses a buffer to cache the most recent 4 kinds of SEA
> errors. If the same kind SEA error continues to occur, GHES will skip to
> reporting this SEA error and will not add it to the "ghes_estatus_llist"
> list until the cache times out after 10 seconds, at which point the SEA
> error will be reprocessed.
>
> The GHES invoke ghes_proc_in_irq() to handle the SEA error, which
> ultimately executes memory_failure() to process the page with hardware
> memory corruption. If the same SEA error appears multiple times
> consecutively, it indicates that the previous handling was incomplete or
> unable to resolve the fault. In such cases, it is more appropriate to
> return a failure when encountering the same error again, and then proceed
> to arm64_do_kernel_sea for further processing.
>
> When hardware memory corruption occurs, a memory error interrupt is
> triggered. If the kernel accesses this erroneous data, it will trigger
> the SEA error exception handler. All such handlers will call
> memory_failure() to handle the faulty page.
>
> If a memory error interrupt occurs first, followed by an SEA error
> interrupt, the faulty page is first marked as poisoned by the memory erro=
r
> interrupt process, and then the SEA error interrupt handling process will
> send a SIGBUS signal to the process accessing the poisoned page.
>
> However, if the SEA interrupt is reported first, the following exceptiona=
l
> scenario occurs:
>
> When a user process directly requests and accesses a page with hardware
> memory corruption via mmap (such as with devmem), the page containing thi=
s
> address may still be in a free buddy state in the kernel. At this point,
> the page is marked as "poisoned" during the SEA claim memory_failure().
> However, since the process does not request the page through the kernel's
> MMU, the kernel cannot send SIGBUS signal to the processes. And the memor=
y
> error interrupt handling process not support send SIGBUS signal. As a
> result, these processes continues to access the faulty page, causing
> repeated entries into the SEA exception handler. At this time, it lead to
> an SEA error interrupt storm.
>
> Fixes this by returning a failure when encountering the same error again.
>
> The following error logs is explained using the devmem process:
>   NOTICE:  SEA Handle
>   NOTICE:  SpsrEl3 =3D 0x60001000, ELR_EL3 =3D 0xffffc6ab42671400
>   NOTICE:  skt[0x0]die[0x0]cluster[0x0]core[0x1]
>   NOTICE:  EsrEl3 =3D 0x92000410
>   NOTICE:  PA is valid: 0x1000093c00
>   NOTICE:  Hest Set GenericError Data
>   [ 1419.542401][    C1] {57}[Hardware Error]: Hardware error from APEI G=
eneric Hardware Error Source: 9
>   [ 1419.551435][    C1] {57}[Hardware Error]: event severity: recoverabl=
e
>   [ 1419.557865][    C1] {57}[Hardware Error]:  Error 0, type: recoverabl=
e
>   [ 1419.564295][    C1] {57}[Hardware Error]:   section_type: ARM proces=
sor error
>   [ 1419.571421][    C1] {57}[Hardware Error]:   MIDR: 0x0000000000000000
>   [ 1419.571434][    C1] {57}[Hardware Error]:   Multiprocessor Affinity =
Register (MPIDR): 0x0000000081000100
>   [ 1419.586813][    C1] {57}[Hardware Error]:   error affinity level: 0
>   [ 1419.586821][    C1] {57}[Hardware Error]:   running state: 0x1
>   [ 1419.602714][    C1] {57}[Hardware Error]:   Power State Coordination=
 Interface state: 0
>   [ 1419.602724][    C1] {57}[Hardware Error]:   Error info structure 0:
>   [ 1419.614797][    C1] {57}[Hardware Error]:   num errors: 1
>   [ 1419.614804][    C1] {57}[Hardware Error]:    error_type: 0, cache er=
ror
>   [ 1419.629226][    C1] {57}[Hardware Error]:    error_info: 0x000000002=
0400014
>   [ 1419.629234][    C1] {57}[Hardware Error]:     cache level: 1
>   [ 1419.642006][    C1] {57}[Hardware Error]:     the error has not been=
 corrected
>   [ 1419.642013][    C1] {57}[Hardware Error]:    physical fault address:=
 0x0000001000093c00
>   [ 1419.654001][    C1] {57}[Hardware Error]:   Vendor specific error in=
fo has 48 bytes:
>   [ 1419.654014][    C1] {57}[Hardware Error]:    00000000: 00000000 0000=
0000 00000000 00000000  ................
>   [ 1419.670685][    C1] {57}[Hardware Error]:    00000010: 00000000 0000=
0000 00000000 00000000  ................
>   [ 1419.670692][    C1] {57}[Hardware Error]:    00000020: 00000000 0000=
0000 00000000 00000000  ................
>   [ 1419.783606][T54990] Memory failure: 0x1000093: recovery action for f=
ree buddy page: Recovered
>   [ 1419.919580][ T9955] EDAC MC0: 1 UE Multi-bit ECC on unknown memory (=
node:0 card:1 module:71 bank:7 row:0 col:0 page:0x1000093 offset:0xc00 grai=
n:1 - APEI location: node:0 card:257 module:71 bank:7 row:0 col:0)
>   NOTICE:  SEA Handle
>   NOTICE:  SpsrEl3 =3D 0x60001000, ELR_EL3 =3D 0xffffc6ab42671400
>   NOTICE:  skt[0x0]die[0x0]cluster[0x0]core[0x1]
>   NOTICE:  EsrEl3 =3D 0x92000410
>   NOTICE:  PA is valid: 0x1000093c00
>   NOTICE:  Hest Set GenericError Data
>   NOTICE:  SEA Handle
>   NOTICE:  SpsrEl3 =3D 0x60001000, ELR_EL3 =3D 0xffffc6ab42671400
>   NOTICE:  skt[0x0]die[0x0]cluster[0x0]core[0x1]
>   NOTICE:  EsrEl3 =3D 0x92000410
>   NOTICE:  PA is valid: 0x1000093c00
>   NOTICE:  Hest Set GenericError Data
>   ...
>   ...        ---> Hapend SEA error interrupt storm
>   ...
>   NOTICE:  SEA Handle
>   NOTICE:  SpsrEl3 =3D 0x60001000, ELR_EL3 =3D 0xffffc6ab42671400
>   NOTICE:  skt[0x0]die[0x0]cluster[0x0]core[0x1]
>   NOTICE:  EsrEl3 =3D 0x92000410
>   NOTICE:  PA is valid: 0x1000093c00
>   NOTICE:  Hest Set GenericError Data
>   [ 1429.818080][ T9955] Memory failure: 0x1000093: already hardware pois=
oned
>   [ 1429.825760][    C1] ghes_print_estatus: 1 callbacks suppressed
>   [ 1429.825763][    C1] {59}[Hardware Error]: Hardware error from APEI G=
eneric Hardware Error Source: 9
>   [ 1429.843731][    C1] {59}[Hardware Error]: event severity: recoverabl=
e
>   [ 1429.861800][    C1] {59}[Hardware Error]:  Error 0, type: recoverabl=
e
>   [ 1429.874658][    C1] {59}[Hardware Error]:   section_type: ARM proces=
sor error
>   [ 1429.887516][    C1] {59}[Hardware Error]:   MIDR: 0x0000000000000000
>   [ 1429.901159][    C1] {59}[Hardware Error]:   Multiprocessor Affinity =
Register (MPIDR): 0x0000000081000100
>   [ 1429.901166][    C1] {59}[Hardware Error]:   error affinity level: 0
>   [ 1429.914896][    C1] {59}[Hardware Error]:   running state: 0x1
>   [ 1429.914903][    C1] {59}[Hardware Error]:   Power State Coordination=
 Interface state: 0
>   [ 1429.933319][    C1] {59}[Hardware Error]:   Error info structure 0:
>   [ 1429.946261][    C1] {59}[Hardware Error]:   num errors: 1
>   [ 1429.946269][    C1] {59}[Hardware Error]:    error_type: 0, cache er=
ror
>   [ 1429.970847][    C1] {59}[Hardware Error]:    error_info: 0x000000002=
0400014
>   [ 1429.970854][    C1] {59}[Hardware Error]:     cache level: 1
>   [ 1429.988406][    C1] {59}[Hardware Error]:     the error has not been=
 corrected
>   [ 1430.013419][    C1] {59}[Hardware Error]:    physical fault address:=
 0x0000001000093c00
>   [ 1430.013425][    C1] {59}[Hardware Error]:   Vendor specific error in=
fo has 48 bytes:
>   [ 1430.025424][    C1] {59}[Hardware Error]:    00000000: 00000000 0000=
0000 00000000 00000000  ................
>   [ 1430.053736][    C1] {59}[Hardware Error]:    00000010: 00000000 0000=
0000 00000000 00000000  ................
>   [ 1430.066341][    C1] {59}[Hardware Error]:    00000020: 00000000 0000=
0000 00000000 00000000  ................
>   [ 1430.294255][T54990] Memory failure: 0x1000093: already hardware pois=
oned
>   [ 1430.305518][T54990] 0x1000093: Sending SIGBUS to devmem:54990 due to=
 hardware memory corruption
>
> Signed-off-by: Junhao He <hejunhao3@h-partners.com>
> ---
>  drivers/acpi/apei/ghes.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 005de10d80c3..eebda39bfc30 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1343,8 +1343,10 @@ static int ghes_in_nmi_queue_one_entry(struct ghes=
 *ghes,
>         ghes_clear_estatus(ghes, &tmp_header, buf_paddr, fixmap_idx);
>
>         /* This error has been reported before, don't process it again. *=
/
> -       if (ghes_estatus_cached(estatus))
> +       if (ghes_estatus_cached(estatus)) {
> +               rc =3D -ECANCELED;
>                 goto no_work;
> +       }
>
>         llist_add(&estatus_node->llnode, &ghes_estatus_llist);
>
> --

This needs a response from the APEI reviewers as per MAINTAINERS, thanks!

