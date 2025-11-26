Return-Path: <linux-edac+bounces-5535-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA4BC8A89C
	for <lists+linux-edac@lfdr.de>; Wed, 26 Nov 2025 16:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD9804ECF16
	for <lists+linux-edac@lfdr.de>; Wed, 26 Nov 2025 15:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D0C3093CD;
	Wed, 26 Nov 2025 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inj62rlI"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C65C3093B6;
	Wed, 26 Nov 2025 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764169555; cv=none; b=B7TtSxdmQgzUYrsX77CMNjVllUMVt073sG2/pAA+B9q14nLNnM4vGTKjXkjf6nGMSbHrO4l3ZP5v1eJEZLzX6Nz5g9CT8ak2xvy8yXZrKHkKG4FMbQiRpLbeBxoWBjAi0x6Ddl8GpbKik3PkunaXYxp4ZTm0EHzYjkghqDLBqw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764169555; c=relaxed/simple;
	bh=ut5Wdj5EXNbIdxj37rKKD3NuxPTvb5K24ZGrRTIGrvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiTYMbw6KCYPlWl3v52fh7ScMFyAYMZaKWi0I/yJ1vby59UmAbrl2cBBRLX+2564qoDG2zSusMeRyrzMmAkZ85ZnI8EtP3JyObZUdOwRL5afjJcRWHojgj0z5pSY9G+H/LpVmDaSCF5lrGc5BTx7jBxrAdH7o4mAjT67ZRFx8Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inj62rlI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88195C116B1;
	Wed, 26 Nov 2025 15:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764169554;
	bh=ut5Wdj5EXNbIdxj37rKKD3NuxPTvb5K24ZGrRTIGrvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=inj62rlIy7CpbFmRWtR0Gi6SQx9XGdjc7lmYdqPU28V8pW6Bj96dUxQvEoIFihZ5w
	 zuBRQS9IH2R7mBPn4JKOg4OuUolgDYpeR10xjfRFDbq/zMQ/+0QNUkNPZf5mYLP86T
	 emkYHfJvfqkQzKEDmCm4w967QE1HFJFjuvXB5EUFEXEXm5Y+6tSyJIiXmRfOrDoTfJ
	 t+dD7w+zgw9+PbcEI2PpeLX78+AatrVHkcAQDS/LaosyeBd/i/84f5obsmTBrDUTPr
	 dFIDrjWTsDkot/FiXkZzJZJFQ1nZy2/05zw+z9oMm9T3Z5loOm9BUY+EC88sKn5e5H
	 DblK3l6KZ1nHg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vOH5c-00000003nvu-1ymR;
	Wed, 26 Nov 2025 16:05:52 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Borislav Petkov" <bp@alien8.de>,
	"Hanjun Guo" <guohanjun@huawei.com>,
	"Ira Weiny" <ira.weiny@intel.com>,
	"Jason Tian" <jason@os.amperecomputing.com>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	"Len Brown" <lenb@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab@kernel.org>,
	"Peter Zijlstra" <peterz@infradead.org>,
	"Shuai Xue" <xueshuai@linux.alibaba.com>,
	"Smita Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>,
	"Tony Luck" <tony.luck@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] apei/ghes: don't go past allocated memory
Date: Wed, 26 Nov 2025 16:05:46 +0100
Message-ID: <3f6764ddbc0b596a43a73616d972c2ba0060d1b1.1764169337.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764169337.git.mchehab+huawei@kernel.org>
References: <cover.1764169337.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

If the BIOS generates a very small ARM Processor Error, or
an incomplete one, the current logic will fail to deferrence

	err->section_length
and
	ctx_info->size

Add checks to avoid that. With such changes, those GHESv2
records won't cause OOPSes:

    GUID: e19e3d16-bc11-11e4-9caa-c2051d5d46b0
    CPER:
      00000000  23 da a0 ce 9a 1b 92 d7 08 2b 32 08 7b 56 1b 23   #........+2.{V.#
      00000010  d5 c1 aa 23 b6 57 f3 d7 7a 72 32 ea 2b fd da bc   ...#.W..zr2.+...
      00000020  4e 52 e3 e4 15 21 53 75 e7 d0 30 22 de cc db ba   NR...!Su..0"....
      00000030  3c 24 56 99 6d 89 e4 f0 ac f3 4d 78 ba bc 5b 25   <$V.m.....Mx..[%
      00000040  e5 9c 2c ac 20 ee 8a af d3 c1 09 02 fd a0 26 e4   ..,. .........&.
      00000050  1b 4b d1 12 af af f1 fa ab 00 71 7d e5 7c 46 88   .K........q}.|F.
      00000060  d7 35 6e 19 da 03 8f 5f 50 51 68 cf 59 1a 6d 91   .5n...._PQh.Y.m.
      00000070  13 e8 53 5d 12 81 ee f4 7c de ae b3 c3 45 5c ef   ..S]....|....E\.
      00000080  29 21 c8 f1 c5 2a 0b 13 9f 17 56 cf f2 2b ec 32   )!...*....V..+.2
      00000090  37 e0 2e bc ac 30 db 33 c0 89 da 7f 39 7c 0b ac   7....0.3....9|..
      000000a0  4f f9 a5 e8 9a 0f 05 cb 96 cb 1a 73 1f 0a f4 b5   O..........s....
      000000b0  0c 02 3f 6b cd 43 29 2f 9e bb 18 2a 2f 0d eb fb   ..?k.C)/...*/...
      000000c0  80 2a c1 46 f6 1a 12 8b 72 87 d0 94 17 b6 fc 2d   .*.F....r......-
      000000d0  4f 07 5a 5d 1d cf d1 81 d6 dd 41 f3 b2 9a 53 4a   O.Z]......A...SJ
      000000e0  7e ee c4 f7 6c 84                                 ~...l.

    GUID: e19e3d16-bc11-11e4-9caa-c2051d5d46b0
    CPER:
      00000000  33 d7 b2 39 26 aa 70 4c bf cf bb d6 d5 31 59 4d   3..9&.pL.....1YM
      00000010  7d e6 3e 5a 09 88 04 78 78 47 16 ae 3d b0 29 52   }.>Z...xxG..=.)R
      00000020  3e 52 c2 d9 6e 04 61 70 42 83 c9 cd 45 ad c3 b6   >R..n.apB...E...
      00000030  3d d0 36 a7 fb 4b f2 5f 8d 90 7f f2 77 05 27 15   =.6..K._....w.'.
      00000040  c0 c8 72 18 7f 50 a8 5d 03 4f 21 27 06 e5 29 bd   ..r..P.].O!'..).
      00000050  02 34 6f d1 35 30 71 31 1f 22 1e 7c 74 90 da 38   .4o.50q1.".|t..8
      00000060  70 5a e1 ed e0 6e 20 7f cb 05 82 02 a1 d9 75 66   pZ...n .......uf
      00000070  c4 62 7d b9 60 95 b3 7a e8 c2 fc b9 ab ab 14 89   .b}.`..z........
      00000080  52 83 65 9a c7 83 7a e6 74 2f c5 a4 6a 39 46 06   R.e...z.t/..j9F.
      00000090  9e d4 7c b0 f4 f6 96 0e da 72 c5 d9 70 43 2c f0   ..|......r..pC,.
      000000a0  0e ae 3f 87 b8 07 89 c2 dd 54 c4 3e 1a 0c ab ae   ..?......T.>....
      000000b0  53 89 5a bc 41 d7 80 c8 ff 28 ab 55 3c 4d 99 87   S.Z.A....(.U<M..
      000000c0  42 ce 11 e8 2c f7 da 5d d3 99 4e 11 86 d7 fc 36   B...,..]..N....6
      000000d0  d1 8f a0 59 46 ba 45 f6 41 03 53 3e 0d 92 f1 8f   ...YF.E.A.S>....
      000000e0  98 49 45 52 ae 5c cc 20 f7 08 2b 3b c0 3d 4c 16   .IER.\. ..+;.=L.
      000000f0  95 b2 a8 f5 ec 1e 6a 12 3a 27 e4 5c d3 39 3f 2e   ......j.:'.\.9?.
      00000100  62 d7 9c ee 75 ea 12 0f cf 09 8a 06 02 23 e6 3a   b...u........#.:
      00000110  a2 ce 20 63 fa f7 10 ee 83 5c 51 12 94 7d b4 a0   .. c.....\Q..}..
      00000120  a9 99 9a 69 92 ba e1 a1 60 d3 98 57 fb 88 34 7a   ...i....`..W..4z
      00000130  2e 61 d0 73 ae 2d 95 70 00 b5 32 a0 b1 57 b9 70   .a.s.-.p..2..W.p
      00000140  f4 bc 37 78 14 a6 5d 1e fa a8 54 e8 8b 00 ea a9   ..7x..]...T.....
      00000150  05 a4 e6 e9 e8 9b ee 31 18 b1 92 41 f1 05 3c d6   .......1...A..<.
      00000160  fa 7d ed 4c 43 15 f1 0c 77 c2 27 54 2e e0 b6 44   .}.LC...w.'T...D
      00000170  73 8c 5a fc d6 0a 63 61 b3 75 5b fe 46 24 7d b5   s.Z...ca.u[.F$}.
      00000180  85 83 9a 7d 17 35 c5 1d 69 dc b0 1d 61 b3 10 95   ...}.5..i...a...
      00000190  e1 46 f9 06 2c 52 09 27 c6 02 13 98 10 e0 2b 82   .F..,R.'......+.
      000001a0  74 5c f1 7e b3 d4 a1 04 58 43 60 36 a8 7b 22 e7   t\.~....XC`6.{".
      000001b0  e8 f2 9c fb ac 23 0b 89 18 49 aa 6a 20 04 a4 82   .....#...I.j ...
      000001c0  c3 68 e7 96 42 85 d8 d9 fc d6 b3 a4 5b 97 02 f0   .h..B.......[...
      000001d0  69 d3 86 63 aa 30 66 09 7a 1f 36 e2 b2 e6 32 d4   i..c.0f.z.6...2.
      000001e0  8d 69 68 a2 3d e0 31 54 95 e6 82 76 13 0b 6c d2   .ih.=.1T...v..l.
      000001f0  04 36 45 77 56 68 c3 ee b7 db a3 1c 0a 3d e7 00   .6EwVh.......=..
      00000200  c0 da 99 b4 54 c4 78 e9 03 23 d3 fd f4 20 bd b2   ....T.x..#... ..
      00000210  34 9c 63 83 04 a6 22 4c 95 8b 93 f8 bb b8 15 01   4.c..."L........
      00000220  42 e6 11 22 fa 7f 3d b4 1e cc 3b c8 4b d7 b9 7c   B.."..=...;.K..|
      00000230  93 16 53 d9 2d 7c 3a aa 09 dd ee 58 cf 80 ef 22   ..S.-|:....X..."
      00000240  e2 60 0b 8f 01 c6 e9 b3 a2 2c f2 a2 48 c2 16 ba   .`.......,..H...
      00000250  b5 62 42 fe 95 ad 80 24 b3 90 a7 23 7e 7d 4c de   .bB....$...#~}L.
      00000260  3e a6 c7 16 20 b9 0d 7b ef e2 21 d3 d9 fc dd d7   >... ..{..!.....
      00000270  22 57 b3 97 a5 81 2f 18 22 06 83 bf cc e3 c3 12   "W..../.".......
      00000280  09 fd 57 55 cd 08 42 14 4d e1 5c 42 02 ae 82 74   ..WU..B.M.\B...t
      00000290  9f f2 3a 87 0e 61 65 d6 51 62 0d 99 38 75 06 30   ..:..ae.Qb..8u.0
      000002a0  5a 98 82 11 9e 1b 40 44 14 34 06 d7 c1 24 b3 5e   Z.....@D.4...$.^
      000002b0  06 f4 2a b1 7d ba bd 9b 9e ef 09 ed bf 5d         ..*.}........]

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/acpi/apei/ghes.c | 10 +++++++++-
 drivers/ras/ras.c        |  6 +++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 8b90b6f3e866..dc748d1992b8 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -564,7 +564,15 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 	char *p;
 
 	sec_sev = ghes_severity(gdata->error_severity);
-	log_arm_hw_error(err, sec_sev);
+	if (length >= sizeof(*err)) {
+		log_arm_hw_error(err, sec_sev);
+	} else {
+		pr_warn(FW_BUG "arm error length: %d\n", length);
+		pr_warn(FW_BUG "length is too small\n");
+		pr_warn(FW_BUG "firmware-generated error record is incorrect\n");
+		return false;
+	}
+
 	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
 		return false;
 
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index 2a5b5a9fdcb3..03df3db62334 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -72,7 +72,11 @@ void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
 	ctx_err = (u8 *)ctx_info;
 
 	for (n = 0; n < err->context_info_num; n++) {
-		sz = sizeof(struct cper_arm_ctx_info) + ctx_info->size;
+		sz = sizeof(struct cper_arm_ctx_info);
+
+		if (sz + (long)ctx_info - (long)err >= err->section_length)
+			sz += ctx_info->size;
+
 		ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
 		ctx_len += sz;
 	}
-- 
2.52.0


