Return-Path: <linux-edac+bounces-4119-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B739EAD72B3
	for <lists+linux-edac@lfdr.de>; Thu, 12 Jun 2025 15:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965EF3A8760
	for <lists+linux-edac@lfdr.de>; Thu, 12 Jun 2025 13:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C96248195;
	Thu, 12 Jun 2025 13:49:40 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D1B23E331;
	Thu, 12 Jun 2025 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749736180; cv=none; b=YzmklFGKAo97TCR4basqStVeBu8Ot4YrK4goKtdVCeZ+BPvE59JV00/H1sjximZw0na49bQCxT2gBEeq70AtyqJLwouur099+lnGVCBUr5qaGk3053L8PKLAKik/Git95CGoSFsFkM9v07Cj8wWbPflOEGAGwUOD9oztLBeMC1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749736180; c=relaxed/simple;
	bh=vM1Gi5glxeC0aGXXy6A4/jHdYsq0naNODjna/tMhEHc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GMRoAsntbmfkwwifeWWkNZ0XTbtl1SEdSZmv5NrNL0GFltAO3/V7JdryvQYdnWonA5jlJEdAqZcBPCTIMSKEAvsNg/vLj1QgYCCe2UJ1YD0jKVkn9MVVErOJMLfjYuwYA/PjHIwAnt/rwHLZNmKpTp1LimoqR/peWFN16lqzGwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id C8A845F824;
	Thu, 12 Jun 2025 13:49:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id EAF6F2000E;
	Thu, 12 Jun 2025 13:49:32 +0000 (UTC)
Date: Thu, 12 Jun 2025 09:49:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, linux-edac@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Borislav Petkov <bp@alien8.de>, Tony Luck
 <tony.luck@intel.com>
Subject: [PATCH] tracing, AER: Hide PCIe AER event when PCIEAER is not
 configured
Message-ID: <20250612094932.4a08abd6@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EAF6F2000E
X-Rspamd-Server: rspamout08
X-Stat-Signature: h4h7shhgddtenk6kgi5y5d97tqqa349s
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18qPn9fd4gpyTjIqY3M7LdPyC4AqqEL6vs=
X-HE-Tag: 1749736172-257217
X-HE-Meta: U2FsdGVkX1/QpRpaxewuMvZQgpfNj6y0FJfkyv1wp4EKYBLc3jQqFcQaRZEEKaXs9wVBCCR4cOYNqVGE/dVATGTcbxB6SmUgjfJE2my6vmRhmVuvcPh28tKulzk8zi6BMyZo76vRmQfBB9LqUKdS4/PxLDcwy0Swt4ePhrMSysSCpX3FaljMOlVaf3oMYksvhZbGL/Sb/ef1ClFcqj4rIYqcFMMtOBV6YIFuaiyC6L2xGqbN/iZy6hC88GE+wTVVbQuSePEKozKnuKpVAAXQXQ2+jB0dCEyfBzqSCMgnGXGm126ykz9nbgokcpL0y5FWzBU+A4b3t+uK5Jy4gU4lWnaPABOhGjupWbShQLL6G5eCKv0xIsD3Y0yAJvkgQORO

From: Steven Rostedt <rostedt@goodmis.org>

The event aer_event is only used when CONFIG_PCIEAER is configured. It
should not be created when it is not. When an event is created it creates
around 5K of text and meta data regardless if the tracepoint is used or
not. Instead of wasting this memory, put #ifdef around the event to not
create it when it is not used.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Note, I will be adding code soon that will make unused events cause a warning.

 include/ras/ras_event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 14c9f943d53f..c8cd0f00c845 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -252,6 +252,7 @@ TRACE_EVENT(non_standard_event,
 		  __print_hex(__get_dynamic_array(buf), __entry->len))
 );
 
+#ifdef CONFIG_PCIEAER
 /*
  * PCIe AER Trace event
  *
@@ -337,6 +338,7 @@ TRACE_EVENT(aer_event,
 			__print_array(__entry->tlp_header, PCIE_STD_MAX_TLP_HEADERLOG, 4) :
 			"Not available")
 );
+#endif /* CONFIG_PCIEAER */
 
 /*
  * memory-failure recovery action result event
-- 
2.47.2


