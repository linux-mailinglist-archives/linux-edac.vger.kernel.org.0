Return-Path: <linux-edac+bounces-4148-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A3AADC922
	for <lists+linux-edac@lfdr.de>; Tue, 17 Jun 2025 13:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3FF1889498
	for <lists+linux-edac@lfdr.de>; Tue, 17 Jun 2025 11:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E232DBF52;
	Tue, 17 Jun 2025 11:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="AGDw9o1e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AD6q4igZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64B3293C72;
	Tue, 17 Jun 2025 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750158836; cv=none; b=spZjnDg8lphH0jd9rva8YjntjSO8KW/aakE3ZDb0xEZpscfjlw97cTsUHZHm96xfpuaiV6UHqSJrlOyiZUxJNf37djark9hq5tLm7B/1SV5ScOyrUp7Ri6yukulL2mqxpV0UyWn6aglAOOHxnioA0UnVzOd6b0C0Y2mUOF8Tvpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750158836; c=relaxed/simple;
	bh=0J50Yh9Ihm5hOfln2lMG8WEBeArpGwD/gDx0nBaforg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=potf63qpLRatU9jfS0lpPfhnOHrSR0W5hR+jfkp+bK0izIS5tiO9LbTXTiAqQaYoHaOmeCMEZ5xYvDtGEgwD/5SR4U4IT2Lf/azWjJhwdJL5z69956P0GxUFr9BbqRdAAfATdq0qu6NAX+oCO2Gc5Nv4Lb71DpfljwqMAWO+iRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=AGDw9o1e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AD6q4igZ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C715B25401A4;
	Tue, 17 Jun 2025 07:13:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 17 Jun 2025 07:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1750158832; x=1750245232; bh=Up
	ee/+xNesRBPJpj9GzDkIAFaqnrWilvSz9Um7c8UxI=; b=AGDw9o1emcsULxO4/l
	pI0SPPdkMME+84d+zHV37omSXODEl2J+GG4b9bxJLyV5HJ7cDaNKy1nioF0mRoIT
	EJHAx/x13u81jOEy0BPUWCr54uPM2HH4Pvzz52UCwGteEVcSMFwST4xKzVg5c/Ro
	5r5dnWyuPNDi2+azP/B5jDm8lmcnnSRvP/G3Xz2vNCX9OhTZqYfhIpNkiFV4Hmz1
	Krh9OrIjO4OEJY1E/CoBwNV07/3ZIIqoixxQc8O3pt0dcAIi/ouBD5F0Ai2SyVA9
	iqb0U+v8XsuM6MAsZ/TPIYr8SitSLTj/FKxS+uauiU5PJNvj0F5/ZGnS8nCiFa6G
	9bUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750158832; x=
	1750245232; bh=Upee/+xNesRBPJpj9GzDkIAFaqnrWilvSz9Um7c8UxI=; b=A
	D6q4igZMYdffeJJMYcZOKy/U8YdVhedp5do+s2Oo+IKneHCRsJvRaZsaR812SOBB
	tkdGU/hASA4Z6gdMjfR1wKMq2xqqMbf8w3dSyTEkCLG38cWNQQyJJ002oy2gcxby
	YHwGoxsOi0xIYKW6LgjDviEhLswe7rf0e/HOX9l5oSmMHnHJ3UKuOu2HGpBhRhUB
	9WgJm95ffac9ZhAdjCw4XksGq5NKIDJsXeYMbGy3apxT3TK2bY1ptTetjinHk7c8
	Ea0C1kuS5zING+y5QZo6YKojQOJp1j49x1Kk4/YEoJBC7XOjDyQVz5T4Y84RRQRS
	LyWLievR8dWYMVG3jay5w==
X-ME-Sender: <xms:8E1RaGB8lBuzVHwhIDpPU6o9QHqhmxrpikxvQBYCHHgXouoHlPdGHg>
    <xme:8E1RaAhRbVYgSPKxLMjqcNVFuRBcaKYml0qjV1SHo5yYBlg6WC2T2fTIzWtB-3M9e
    fECpTlT-AibcQ>
X-ME-Received: <xmr:8E1RaJkIGZ6sPuKNx3UJxgfbT14SH0JU5dvS4fHmXZRINsyXba3P-isWhl_goMR30iiHPG66unX8TkemyYhD2m1JH1Ao4h31evI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfggtggusehgtderredttdejnecuhfhr
    ohhmpeforghrvghkucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmh
    grrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrght
    thgvrhhnpefgtdfgvdetteffleeugfdugfegjeekgfefffdvheffhfdtfeeggfeuhedtff
    euleenucffohhmrghinhepqhhusggvshdqohhsrdhorhhgnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhmrghrvghksehinhhvihhsih
    gslhgvthhhihhnghhslhgrsgdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhonhihrdhluhgtkhesihhnthgvlhdrtghomhdprh
    gtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopehqihhugihurdiihhhu
    ohesihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdgvuggrtgesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8E1RaEyLUa7ywPJTeoSM7zkF8WiSanG7VC1cadI7hrp5GLv1cQqX9Q>
    <xmx:8E1RaLRbMgqnKMn-8NQH9HjVGdCuR6NuYgWo1XMl3b6eRQY0oJ6vfA>
    <xmx:8E1RaPZfq7jyNjof4-DHg0Gqt0xc6ZymE6VLzxN5NAuaHa1BEpIq-w>
    <xmx:8E1RaERxlNYK74J3K7DP6XxKnP6vgFFzxlxVy4fLrgExCs34l3ikUg>
    <xmx:8E1RaLy_WjepWBUEPtsZ3ccV_uy0UAqz12_6V_WIlBDKzsYZIMgwO-aa>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jun 2025 07:13:51 -0400 (EDT)
Date: Tue, 17 Jun 2025 13:13:49 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: "open list:EDAC-IGEN6" <linux-edac@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: NULL pointer dereference in igen6_probe - 6.16-rc2
Message-ID: <aFFN7RlXkaK_loQb@mail-itl>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8Bm/PtQiTEC6mGZ8"
Content-Disposition: inline


--8Bm/PtQiTEC6mGZ8
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jun 2025 13:13:49 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: "open list:EDAC-IGEN6" <linux-edac@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: NULL pointer dereference in igen6_probe - 6.16-rc2

Hi,

Environment:
- Novacustom V540TU laptop with Intel Core 5 Ultra 125H
- Dasharo firmware (coreboot+EDK2)
- Linux running as Xen PV dom0

I hit the following crash on boot:

[   13.562085] intel_pmc_core INT33A1:00: Assuming a default substate order=
 for this platform
[   13.562682] intel_pmc_core INT33A1:00:  initialized
[   13.565035] EDAC MC0: Giving out device to module igen6_edac controller =
Intel_client_SoC MC#0: DEV 0000:00:00.0 (INTERRUPT)
[   13.565746] EDAC igen6: Expected 2 mcs, but only 1 detected.
[   13.565859] BUG: unable to handle page fault for address: 000000000000d5=
70
[   13.566623] #PF: supervisor read access in kernel mode
[   13.566956] #PF: error_code(0x0000) - not-present page
[   13.567276] PGD 0 P4D 0=20
[   13.567460] Oops: Oops: 0000 [#1] SMP NOPTI
[   13.567742] CPU: 8 UID: 0 PID: 1090 Comm: (udev-worker) Not tainted 6.16=
=2E0-0.rc2.1.qubes.1.fc41.x86_64 #1 PREEMPT(full)=20
[   13.568432] Hardware name: Notebook V54x_6x_TU/V54x_6x_TU, BIOS Dasharo =
(coreboot+UEFI) v0.9.0 07/17/2024
[   13.569049] RIP: e030:ecclog_handler+0x7e/0xf0 [igen6_edac]
[   13.569440] Code: 66 4d 63 ee 48 8b 15 21 c7 01 00 49 83 fd 03 73 6b 4d =
69 ed 50 03 00 00 41 8b 47 1c 41 03 47 18 4c 01 ea 48 03 82 08 03 00 00 <48=
> 8b 30 4a 8d 04 26 48 39 c5 72 ba 48 8b 0d f7 c6 01 00 8b 41 1c
[   13.570602] RSP: e02b:ffffc900428979c8 EFLAGS: 00010202
[   13.570951] RAX: 000000000000d570 RBX: 0000000000000000 RCX: 00000000000=
000ca
[   13.571403] RDX: ffff888101dcab50 RSI: ffffffffffffffff RDI: ffffffff834=
84238
[   13.571895] RBP: bffffffffffffffe R08: 0000000000000002 R09: 00000000000=
000c0
[   13.572358] R10: 0000000000000000 R11: ffffffff81612e60 R12: c0000000000=
00000
[   13.572820] R13: 0000000000000350 R14: 0000000000000001 R15: ffffffffc11=
b9c00
[   13.573302] FS:  0000706cbfc6fbc0(0000) GS:ffff8882133db000(0000) knlGS:=
0000000000000000
[   13.573812] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.574199] CR2: 000000000000d570 CR3: 0000000104a0a000 CR4: 00000000000=
50660
[   13.574658] Call Trace:
[   13.574836]  <TASK>
[   13.574985]  igen6_probe+0x2a0/0x343 [igen6_edac]
[   13.575332]  local_pci_probe+0x42/0x90
[   13.575599]  pci_call_probe+0x5b/0x180
[   13.575863]  pci_device_probe+0x95/0x140
[   13.576133]  ? driver_sysfs_add+0x57/0xc0
[   13.576415]  really_probe+0xdb/0x340
[   13.576664]  ? pm_runtime_barrier+0x54/0x90
[   13.576940]  ? __pfx___driver_attach+0x10/0x10
[   13.577234]  __driver_probe_device+0x78/0x110
[   13.577569]  driver_probe_device+0x1f/0xa0
[   13.577833]  __driver_attach+0xba/0x1c0
[   13.578080]  bus_for_each_dev+0x8b/0xe0
[   13.578328]  bus_add_driver+0x142/0x220
[   13.578571]  driver_register+0x72/0xd0
[   13.578823]  igen6_init+0xc5/0xff0 [igen6_edac]
[   13.579122]  ? __pfx_igen6_init+0x10/0x10 [igen6_edac]
[   13.579479]  do_one_initcall+0x57/0x310
[   13.579503]  do_init_module+0x90/0x250
[   13.579969]  init_module_from_file+0x88/0xd0
[   13.579991]  idempotent_init_module+0x114/0x310
[   13.579997]  __x64_sys_finit_module+0x6d/0xd0
[   13.580773]  do_syscall_64+0x84/0x2c0
[   13.581011]  ? count_memcg_events+0x167/0x1d0
[   13.581314]  ? handle_mm_fault+0x220/0x340
[   13.581576]  ? do_user_addr_fault+0x2c3/0x7f0
[   13.581876]  ? clear_bhb_loop+0x50/0xa0
[   13.582125]  ? clear_bhb_loop+0x50/0xa0
[   13.582377]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   13.582724] RIP: 0033:0x706cc04ffd9d
[   13.582967] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 43 60 0f 00 f7 d8 64 89 01 48
[   13.584097] RSP: 002b:00007ffceaf1b958 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000139
[   13.584595] RAX: ffffffffffffffda RBX: 00005aaee2a15d20 RCX: 0000706cc04=
ffd9d
[   13.585029] RDX: 0000000000000000 RSI: 0000706cbeff93bd RDI: 00000000000=
0002b
[   13.585458] RBP: 00007ffceaf1ba10 R08: 0000000000000001 R09: 00007ffceaf=
1b9c0
[   13.585885] R10: 0000000000000040 R11: 0000000000000246 R12: 0000706cbef=
f93bd
[   13.586316] R13: 0000000000020000 R14: 00005aaee2a85900 R15: 00005aaee2a=
84c30
[   13.586753]  </TASK>
[   13.586899] Modules linked in: processor_thermal_power_floor processor_t=
hermal_mbox int340x_thermal_zone intel_pmc_core igen6_edac(+) fjes(-) pmt_t=
elemetry pmt_class intel_pmc_ssram_telemetry intel_hid intel_scu_pltdrv spa=
rse_keymap joydev fuse loop xenfs nfnetlink vsock_loopback vmw_vsock_virtio=
_transport_common vmw_vsock_vmci_transport vsock zram vmw_vmci lz4hc_compre=
ss lz4_compress dm_thin_pool dm_persistent_data dm_bio_prison dm_crypt xe d=
rm_ttm_helper drm_suballoc_helper gpu_sched drm_gpuvm drm_exec drm_gpusvm i=
915 i2c_algo_bit sdhci_pci drm_buddy nvme sdhci_uhs2 ttm polyval_clmulni in=
tel_pmc_mux nvme_core sdhci ghash_clmulni_intel drm_display_helper typec sh=
a512_ssse3 cqhci nvme_keyring xhci_pci hid_multitouch sha1_ssse3 mmc_core x=
hci_hcd intel_vpu nvme_auth intel_vsec cec i2c_hid_acpi i2c_hid video thund=
erbolt wmi pinctrl_meteorlake serio_raw xen_acpi_processor xen_privcmd xen_=
pciback xen_blkback xen_gntalloc xen_gntdev xen_evtchn scsi_dh_rdac scsi_dh=
_emc scsi_dh_alua uinput
[   13.589346] Adding 3986428k swap on /dev/zram0.  Priority:100 extents:1 =
across:3986428k SSDsc
[   13.592314] CR2: 000000000000d570
[   13.592473] ---[ end trace 0000000000000000 ]---
[   13.593400] RIP: e030:ecclog_handler+0x7e/0xf0 [igen6_edac]
[   13.593831] Code: 66 4d 63 ee 48 8b 15 21 c7 01 00 49 83 fd 03 73 6b 4d =
69 ed 50 03 00 00 41 8b 47 1c 41 03 47 18 4c 01 ea 48 03 82 08 03 00 00 <48=
> 8b 30 4a 8d 04 26 48 39 c5 72 ba 48 8b 0d f7 c6 01 00 8b 41 1c
[   13.595067] RSP: e02b:ffffc900428979c8 EFLAGS: 00010202
[   13.595077] RAX: 000000000000d570 RBX: 0000000000000000 RCX: 00000000000=
000ca
[   13.595078] RDX: ffff888101dcab50 RSI: ffffffffffffffff RDI: ffffffff834=
84238
[   13.595080] RBP: bffffffffffffffe R08: 0000000000000002 R09: 00000000000=
000c0
[   13.595083] R10: 0000000000000000 R11: ffffffff81612e60 R12: c0000000000=
00000
[   13.595084] R13: 0000000000000350 R14: 0000000000000001 R15: ffffffffc11=
b9c00
[   13.595100] FS:  0000706cbfc6fbc0(0000) GS:ffff8882133db000(0000) knlGS:=
0000000000000000
[   13.598301] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.598308] CR2: 000000000000d570 CR3: 0000000104a0a000 CR4: 00000000000=
50660
[   13.598319] Kernel panic - not syncing: Fatal exception
[   13.598384] Kernel Offset: disabled

Full console log: https://openqa.qubes-os.org/tests/143433/logfile?filename=
=3Dserial0.txt

Other observations:
- Linux 6.15 works fine
- the same Linux 6.16-rc2 boots fine on several other systems, for
  example on Intel i5 14600K (also with Dasharo firmware)

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--8Bm/PtQiTEC6mGZ8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmhRTe0ACgkQ24/THMrX
1yzQcwf8DK1hWOtvKu1WTmZgSkB4AylFqraF/WZiIlB1O5Up0QgvIVO2Sugd9SSY
bHxOZ7pYw6gIoXnXWHQKkB3iss25gXyDt8eJ+x+wquApPqr5IOZQEsUtaVCttMNO
9Fokv26chPCxIns2jQLv/Lb+5xYNHQQ1fQzD7Ywl3IDVePCECg0wxxsvjVmf9xAp
6M1IPC5TN0TwJZ7ejGlh/d3YG9irsbuv0oKU9Hr+r803xZim8dB2MjuWkLpXpQCS
m27b2EiDKgfQhXNenv6YjDPiBNKvW2s+WZrcLVwm/Aoix7ofA/e4Xtg9O6ooTloZ
/kusETk/F/wIwRBufCC/H6lGV7dwUw==
=kVrN
-----END PGP SIGNATURE-----

--8Bm/PtQiTEC6mGZ8--

