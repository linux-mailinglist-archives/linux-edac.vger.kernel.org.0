Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A07D4601C1
	for <lists+linux-edac@lfdr.de>; Sat, 27 Nov 2021 22:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356330AbhK0VwK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 27 Nov 2021 16:52:10 -0500
Received: from mail.ispras.ru ([83.149.199.84]:33634 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356437AbhK0VuK (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 27 Nov 2021 16:50:10 -0500
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Nov 2021 16:50:09 EST
Received: from [10.10.3.121] (unknown [10.10.3.121])
        by mail.ispras.ru (Postfix) with ESMTPS id B5CAE40755CF;
        Sat, 27 Nov 2021 21:40:48 +0000 (UTC)
Date:   Sun, 28 Nov 2021 00:40:48 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     linux-edac@vger.kernel.org
cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Excessive delays from GHES polling on dual-socket AMD EPYC
Message-ID: <878e4019-3a88-798e-4427-7efb5289a4e1@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello world,

when lightly testing a dual-socket server with 64-core AMD processors I
noticed that workloads running on cpu #0 can exhibit significantly worse
latencies compared to cpu #1 ... cpu #255. Checking SSD response time,
on cpu #0 I got:

taskset -c 0 ioping -R /dev/sdf

--- /dev/sdf (block device 1.75 TiB) ioping statistics ---
70.7 k requests completed in 2.97 s, 276.3 MiB read, 23.8 k iops, 93.1 MiB/s
generated 70.7 k requests in 3.00 s, 276.4 MiB, 23.6 k iops, 92.1 MiB/s
min/avg/max/mdev = 33.1 us / 41.9 us / 87.9 ms / 452.6 us

Notice 87.9 millisecond maximum response time, and compare with its
hyperthread sibing:

taskset -c 128 ioping -R /dev/sdf

--- /dev/sdf (block device 1.75 TiB) ioping statistics ---
80.5 k requests completed in 2.96 s, 314.5 MiB read, 27.2 k iops, 106.2 MiB/s
generated 80.5 k requests in 3.00 s, 314.5 MiB, 26.8 k iops, 104.8 MiB/s
min/avg/max/mdev = 33.2 us / 36.8 us / 89.2 us / 2.00 us

Of course maximum times themselves vary from run to run, but the general
picture stays: on cpu #0 I get about three orders of magnitude
longer latencies. I think this is outside of "latency-sensitive
workloads might care" territory and closer to "hurts everyone" kind of
issue, hence I'm reporting it.


On this machine there's AMD HEST ACPI table that registers 14342 polled
"generic hardware error sources" (GHES) with poll interval 5 seconds.
(this seems misdesigned: it will cause cross-socket polling unless the
OS takes special care to divine which GHES to poll from where)

Linux setups a timer for each of those individually, so when the machine
is idle there's approximately 2800 timers per second invoked on cpu #0.
Plus, there's a secondary issue with timer migration:
get_nohz_timer_target will attempt to select a non-idle CPU out of 256
(visiting some CPUs repeatedly if they appear in nested domains), and
fail. If I help it along by running 'taskset -c 1 yes > /dev/null' or
disable kernel.timer_migration entirely, it drops maximum latency in the
above ioping test to 1..10ms range (down to two orders of magnitude from
three).

I guess the short answer is that if I don't like it I can boot that
server with 'ghes_disable=1', but is a proper solution possible? Like
requiring explicit opt-in to honor polled GHES entries?

Thank you.
Alexander
