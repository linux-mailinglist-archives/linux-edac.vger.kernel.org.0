Return-Path: <linux-edac+bounces-4320-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D167CAF90F9
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jul 2025 12:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E4E1CA3768
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jul 2025 10:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68AD2F2737;
	Fri,  4 Jul 2025 10:55:46 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12551F419B;
	Fri,  4 Jul 2025 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751626546; cv=none; b=vFLer6gUwuvgZCBxyNJ9L4BhFoP4szeR7sNJwsDXZellsQteb2zGKQN2MlqPYjOCYZdAJfYgFpyEGzPUFvBaQ/aQ+JU8iJiiyxt3cd8G5xGAKfO0Q+8g+3jyPXhp2VR3t7zgtiHTvo2AMewfNT0atxW3VrVB2rO/VMiOp5//L6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751626546; c=relaxed/simple;
	bh=1U1z1g4EWNPlabCXdHT1aG1bOMPJnooVpW/UGp/hslE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bOob/DxzmELW0HgK4NkGxZlGO4k74SCUf9bdvfc8UTTLisd0a5KhaoJQsABir1Cg0FLa0eyCenfUGiwzzsrtcS86ZvfRNuGhB8geD53Xr03HuKDo1ggGdkLxpATnP8RxlK0NSSgyB+SiWmYQkO/2ZbtegghwS78OZiGC8nOp3vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-608acb0a27fso1193339a12.0;
        Fri, 04 Jul 2025 03:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751626543; x=1752231343;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnRo145nfkK9QuBJyViLREKLiDY2khAyxi7Lvw4HNyQ=;
        b=NryTvJzg6zNNMJp2KvMYHmyoTBsyIxNlMi9WNboOT3QJYxnWCCcV667n6t7EiHRNGh
         KbFzVubGDojgnutpqJOwarSwRPDR0GcTYh5cxPvk8bBA3jUJolLbmzx0Onm+civprqR2
         Bm5ezVdjwnXb3Eel+FJlSVDtilP2oYSksYq4cNrf4GBey3XN+xVRqDZk5qI6JSe7CT5r
         pfefqiCfnCKZUaWyl/LP5WpHg39GjplLtH30gl2K1+itvQZ+6t5G+NGkgCP0yPOUiNDJ
         0GK4laE0slZw263iJ1U/nQq9hYEmzH/OTA1AAgDTOBt6mAXAX+s8wuwnEt9Ct8/1FHBh
         EcnA==
X-Forwarded-Encrypted: i=1; AJvYcCUfiY20wE9o9YC0ZgZhJ9VETGrJt/nfILSZ3WR+/4CJZUKGBlgl4PCnjKiJa39GlgJ54HZUr9j2d4wB5A==@vger.kernel.org, AJvYcCVgqe3GWEd0nlhZ8sxPwL9ntYtHvASox9N6Or78lThgYO/AvE4pmR/Q0ehpLEj8uvlynaP8b17xlntl@vger.kernel.org, AJvYcCXVUyY23EGWGyoaX+j8OABJNp2sq2VchCY6jEUDdQAjBb16BmWpwiTBDML0rmQZ5nqyrzHJS4vsMy3GxEnQ@vger.kernel.org, AJvYcCXd+8ZxuQgwyzbBDeXnPV4gWSbzI/uCh4RNCsoodw+u/BmdcVoBW76zsvd5e/7brgLsaXkaLBqPbU6X@vger.kernel.org
X-Gm-Message-State: AOJu0YwnGiprto2eIWo+ClYfZZCLveFe0YaR4q3jYpVKj99lHd33YaXq
	5b9czZGZIUIs5U/LaJffoC8ZEbjP3yaMVmI4ACTtVkhRUcD0vyiO4eJj/RNkBrRd
X-Gm-Gg: ASbGnctH6L26BgHjahUP8HF77JWtEyRSqgIgOnS3JcbJFBLyoSwehNQpNSgTsQCbO44
	Pw8kxaMWSpPsllL0HsHmznbfSXmqDvTbx40r7S55Hm2VlzcMl0cb0M3aNKmsV7tfWyMuBhsmqqy
	tTH61GLuie1ShekAGZsG6KfBZLWEF+qxUOhtby7/s7J561I9FvTqHERn1pJH67GQMoVHTJQ8Rnt
	r/hPNfooglXYjS6TraX+BQ5x7pAf+RkA99KMmjni3EL1i95ami1McQcfVCPZ5H3QZPN7w/QNjUq
	nVi0HtljnMjXFeYBDuh/h0t4dXXu2ZGapoK+hqOdeddfMtyOhl9mYg==
X-Google-Smtp-Source: AGHT+IEUUlaP5Uj88xQKBdaUuNcoTE/9tGToatmRzQjANlxnwdqmOP0i05xJreCnnwNNZA5ZyTkmFA==
X-Received: by 2002:a05:6402:13cc:b0:604:e33f:e5c0 with SMTP id 4fb4d7f45d1cf-60fd6e2078cmr1640262a12.30.1751626542839;
        Fri, 04 Jul 2025 03:55:42 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb8c758asm1147398a12.79.2025.07.04.03.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 03:55:42 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 04 Jul 2025 03:55:19 -0700
Subject: [PATCH 1/2] panic: add taint flag for recoverable hardware errors
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-taint_recovered-v1-1-7a817f2d228e@debian.org>
References: <20250704-taint_recovered-v1-0-7a817f2d228e@debian.org>
In-Reply-To: <20250704-taint_recovered-v1-0-7a817f2d228e@debian.org>
To: Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, tony.luck@intel.com, rafael@kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, kbusch@kernel.org, rmikey@meta.com, 
 kuba@kernel.org, ast@kernel.org, linux-edac@vger.kernel.org, 
 mchehab@kernel.org, bp@alien8.de, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3834; i=leitao@debian.org;
 h=from:subject:message-id; bh=1U1z1g4EWNPlabCXdHT1aG1bOMPJnooVpW/UGp/hslE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoZ7MrV5o0cEJlsftNYaBg4QVYXzZVGm3PkRYHe
 D8DvyA85ZKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaGezKwAKCRA1o5Of/Hh3
 bZ3YD/4qk9aZJm5t/I/WXN4rGCaHry6iWPEvaa8J3yMRs7H8x4aBULpzoYpiwxtUHmlxZJnJ3qU
 Kt4cZgLTJZ3PDDGHdgtMA18Xurm1gQXEkvBFY8Q2m4p8BXXvK8GbDSUX1+1+fU1VmDLxqs7vW9J
 E91PLl+Zj2+rnjVWuorITYj/ceDoSUzXH88ODnksb2pQDZkf2JE0h3YI22IIwUaV73Dd4u8yzhu
 tPSt4zmYpqwZcH0p0i8Eo+XP9hwKjWkc/koMGhUzlbPNfEJH7F6FLEgs0wcy6+9Yo2CcmHEQwVy
 1yHbUKfrwfkXEeJyXVme68+vWZt0nOtIEuoxtLiW7ejwOjWWbLJHK2TCBfdmcaOz3oZ/LBCzrL3
 qJ0vIcaAqEH4x6PaTBFqxyITf4s9E8t8q/tSs9TwWltJHRn2CIC5ZrHRUG17yMXtbBFnc6EnvnW
 bd6EqxZCBD3WhKXLQBscoUp90hCuPiT9Ab4prWwbM1h+KJoT8N/docq2u43+n9xKEIX0saEc1RD
 wheLNrMo1qdV59Itg8KJfmGCC9fqoT3yeWMnvc1ArWA8qxkNFLESSMWJYeajva7Z99cfPMdzKAU
 efExcKuv1CbMlDQAISz7clTEFxRnqpi5xG2omMDiafcf6Bxf/79ThPRgBgY3LC0PFyKLRfGvj2m
 RRSrBjwry4IfRhw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This change introduces a new taint flag, bit 20 ('H'), to indicate when
the kernel has identified recoverable hardware failures during runtime.

The flag is documented in tainted-kernels.rst, defined in panic.h, added
to the taint_flags array in panic.c, and supported in the
kernel-chktaint debugging tool.

Marking kernels that have encountered recoverable hardware errors helps
correlate future issues with hardware events, improving diagnostics and
support for affected systems

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 Documentation/admin-guide/tainted-kernels.rst | 7 ++++++-
 include/linux/panic.h                         | 3 ++-
 kernel/panic.c                                | 1 +
 tools/debugging/kernel-chktaint               | 8 ++++++++
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index a0cc017e44246..28185e9c0e039 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -102,7 +102,8 @@ Bit  Log  Number  Reason that got the kernel tainted
  17  _/T  131072  kernel was built with the struct randomization plugin
  18  _/N  262144  an in-kernel test has been run
  19  _/J  524288  userspace used a mutating debug operation in fwctl
-===  ===  ======  ========================================================
+ 20  _/H 1048576  hardware recoverable failures identified
+===  === =======  ========================================================
 
 Note: The character ``_`` is representing a blank in this table to make reading
 easier.
@@ -189,3 +190,7 @@ More detailed explanation for tainting
  19) ``J`` if userpace opened /dev/fwctl/* and performed a FWTCL_RPC_DEBUG_WRITE
      to use the devices debugging features. Device debugging features could
      cause the device to malfunction in undefined ways.
+
+ 20) ``H`` if the kernel identified any recoverable hardware failure earlier
+     during its operation. This helps to correlate possible future issues to
+     the fact that the hardware got a recoverable error.
diff --git a/include/linux/panic.h b/include/linux/panic.h
index 4adc657669354..d8241a052d69a 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -73,7 +73,8 @@ static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
 #define TAINT_RANDSTRUCT		17
 #define TAINT_TEST			18
 #define TAINT_FWCTL			19
-#define TAINT_FLAGS_COUNT		20
+#define TAINT_HW_ERROR_RECOVERED	20
+#define TAINT_FLAGS_COUNT		21
 #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
 
 struct taint_flag {
diff --git a/kernel/panic.c b/kernel/panic.c
index b0b9a8bf4560d..fd13baf5d94bc 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -540,6 +540,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	TAINT_FLAG(RANDSTRUCT,			'T', ' ', true),
 	TAINT_FLAG(TEST,			'N', ' ', true),
 	TAINT_FLAG(FWCTL,			'J', ' ', true),
+	TAINT_FLAG(HW_ERROR_RECOVERED,		'H', ' ', false),
 };
 
 #undef TAINT_FLAG
diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
index e7da0909d0970..b2099155a820c 100755
--- a/tools/debugging/kernel-chktaint
+++ b/tools/debugging/kernel-chktaint
@@ -212,6 +212,14 @@ else
 	echo " * fwctl's mutating debug interface was used (#19)"
 fi
 
+T=`expr $T / 2`
+if [ `expr $T % 2` -eq 0 ]; then
+	addout " "
+else
+	addout "H"
+	echo " * the kernel identified recoverable hardware errors (#20)"
+fi
+
 echo "For a more detailed explanation of the various taint flags see"
 echo " Documentation/admin-guide/tainted-kernels.rst in the Linux kernel sources"
 echo " or https://kernel.org/doc/html/latest/admin-guide/tainted-kernels.html"

-- 
2.47.1


